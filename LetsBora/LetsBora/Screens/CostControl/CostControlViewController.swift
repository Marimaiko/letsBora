import UIKit

// PROVISÓRIO
struct Expense {
    let title: String
    let detail: String
    let amount: String
    let image: UIImage?
}

class CostControlViewController: UIViewController {
    
    var screen: CostControlView?
    
    var expenses: [Expense] = [
        Expense(title: "Uber", detail: "Corrida de ida", amount: "R$50,00", image: UIImage(systemName: "car")),
        Expense(title: "Água", detail: "Para os convidados", amount: "R$30,00", image: UIImage(systemName: "drop"))
    ]
    
    var participants: [User] = [
        User(name: "Ana Clara", photo: "julia"),
        User(name: "Carlos", photo: "joao")
    ]
    
    override func loadView() {
        screen = CostControlView()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViews()
        updateTableHeights()
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
    }
    
    @objc func didTapNewExpense() {
        let modal = NewExpenseViewController()
        
        modal.onSave = { [weak self] newExpense in
            guard let self = self else { return }
            
            self.expenses.append(newExpense)
            self.screen?.expensesTableView.reloadData()
            self.updateTableHeights()
        }

        modal.modalPresentationStyle = .pageSheet
        if let sheet = modal.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(modal, animated: true)
    }
    
    // MARK: - Setup
    private func setupTableViews() {
        guard let screen = screen else { return }

        screen.expensesTableView.dataSource = self
        screen.expensesTableView.delegate = self
        screen.expensesTableView.register(ExpenseCell.self, forCellReuseIdentifier: ExpenseCell.identifier)

        screen.participantsTableView.dataSource = self
        screen.participantsTableView.delegate = self
        screen.participantsTableView.register(ParticipantCell.self, forCellReuseIdentifier: ParticipantCell.identifier)
    }

    // MARK: - Table Height Updates
    private func updateTableHeights() {
        guard let screen = screen else { return }

        let cellHeight: CGFloat = 76 // Altura real considerando padding

        screen.expensesTableHeightConstraint?.constant = CGFloat(expenses.count) * cellHeight
        screen.participantsTableHeightConstraint?.constant = CGFloat(participants.count) * cellHeight

        screen.layoutIfNeeded()
    }
}

// MARK: - TableView DataSource & Delegate
extension CostControlViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == screen?.expensesTableView {
            return expenses.count
        } else if tableView == screen?.participantsTableView {
            return participants.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == screen?.expensesTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseCell.identifier, for: indexPath) as? ExpenseCell else {
                return UITableViewCell()
            }
            let expense = expenses[indexPath.row]
            cell.configure(image: expense.image, title: expense.title, description: expense.detail, value: expense.amount)
            return cell
            
        } else if tableView == screen?.participantsTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ParticipantCell.identifier, for: indexPath) as? ParticipantCell else {
                return UITableViewCell()
            }
            let participant = participants[indexPath.row]
            cell.configure(name: participant.name, imageName: participant.photo ?? "")
            return cell
        }
        
        return UITableViewCell()
    }
}

