import Foundation
import Combine
import UIKit

protocol EstimateViewModelProtocol: AnyObject {
    func updateDataSource(animated: Bool)
    func makeDataSource() -> UICollectionViewDiffableDataSource<FormSectionComponent, FormComponent>
    func estimatesDidUpdate()
}

final class EstimateViewModel {
    weak var delegate: EstimateViewModelProtocol?

    private let network: Network
    private(set) var estimates: [Estimate] = []

    lazy var formContentBuilder = FormContentBuilder()
    var subscriptions = Set<AnyCancellable>()

    init(network: Network) {
        self.network = network
    }

    func fetchEstimates() {
        Task {
            do {
                let response: FetchEstimatesResponse = try await network.fetch(EstimatesRequest())
                self.estimates = response.estimates
                DispatchQueue.main.async {
                    self.delegate?.estimatesDidUpdate()
                }
            } catch {
                print("Failed to fetch estimates: \(error.localizedDescription)")
            }
        }
    }

    func createEstimate(_ newEstimate: [String: Any]) {
        print("Create Estimate Item")

        guard let bill = newEstimate["bill"] as? String,
              let amountString = newEstimate["amount"] as? String,
              let estimateString = newEstimate["estimate"] as? String,
              let month = newEstimate["month"] as? Date else {
            print("Invalid user input format: \(newEstimate)")
            return
        }

        let formattedMonth = month.toBrazilianDateFormat()

        guard let amount = amountString.convertCurrencyToDouble(),
              let estimateValue = estimateString.convertCurrencyToDouble() else {
            print("Failed to convert currency strings to Double")
            return
        }

        let estimateDict: [String: Any] = [
            "mounth": formattedMonth,
            "bill": bill,
            "estimate": estimateValue,
            "amount": amount,
            "paid": false,
        ]

        print("Message to send:", estimateDict)

        // TODO: Replace with async POST request using Request type
        // Placeholder to keep behavior as-is for now:
        Networker.shared.createNewEstimate(
            newEstimate: estimateDict
        ) { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.fetchEstimates()
                }
            } else {
                print("Failed to create estimate.")
            }
        }
    }

    func getEstimate(at index: Int) -> Estimate {
        estimates[index]
    }

    var estimatedCount: Int {
        estimates.count
    }

    func updateEstimate(_ estimate: Estimate, at index: Int) {
        guard index < estimates.count else { return }
        estimates[index] = estimate
        delegate?.estimatesDidUpdate()
    }

    func newUserSubscribe() {
        formContentBuilder.user
            .sink { [weak self] newEstimate in
                self?.createEstimate(newEstimate)
                self?.delegate?.updateDataSource(animated: false)
            }
            .store(in: &subscriptions)
    }

    func dequeueAndBindFormCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: FormComponent
    ) -> UICollectionViewCell {
        switch item {
        case is FormTextFieldComponent:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FormTextCollectionViewCell.cellId,
                for: indexPath
            ) as! FormTextCollectionViewCell
            cell.subject
                .sink { [weak self] val, index in
                    self?.formContentBuilder.update(val: val, at: index)
                }
                .store(in: &subscriptions)
            cell.bind(item, at: indexPath)
            return cell

        case is FormDateComponent:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FormDateCollectionViewCell.cellId,
                for: indexPath
            ) as! FormDateCollectionViewCell
            cell.subject
                .sink { [weak self] val, index in
                    self?.formContentBuilder.update(val: val, at: index)
                }
                .store(in: &subscriptions)
            cell.bind(item, at: indexPath)
            return cell

        case is FormNumberPriceComponent:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FormNumberPriceCollectionViewCell.cellId,
                for: indexPath
            ) as! FormNumberPriceCollectionViewCell
            cell.subject
                .sink { [weak self] val, index in
                    self?.formContentBuilder.update(val: val, at: index)
                }
                .store(in: &subscriptions)
            cell.bind(item, at: indexPath)
            return cell

        case is ButtonFormComponent:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FormButtonCollectionViewCell.cellId,
                for: indexPath
            ) as! FormButtonCollectionViewCell
            cell.subject
                .sink { [weak self] formId in
                    if formId == .submitButton {
                        self?.formContentBuilder.validate()
                    }
                }
                .store(in: &subscriptions)
            cell.bind(item)
            return cell

        default:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "Cell",
                for: indexPath
            )
        }
    }
}
