//
//  CreateEventGuestModalViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 01/06/25.
//
import UIKit
class CreateEventGuestModalViewController: UIViewController {
    private var screen: CreateEventGuestModalView?
    private let usersToInvite: [User]
    private var guestsSelected: [User]
    var onGuestsSelected: (([User]) -> Void)?
    
    // MARK: - Init
    init(guests: [User], selectedGuests: [User]) {
        self.usersToInvite = guests
        self.guestsSelected = selectedGuests
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfecycle
    override func loadView() {
        screen = CreateEventGuestModalView()
        view  = screen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        screen?.delegateTableView(to: self, data: self)
    }
    
    // MARK: - Setup UI
    func setupNavigationBar() {
        navigationItem.title = "Selecionar Convidados"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "OK",
            style: .done,
            target: self,
            action: #selector(handleDone)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancelar",
            style: .plain,
            target: self,
            action: #selector(handleCancel)
        )
    }
    
    // MARK: Functions
    private func isSelected(_ user: User) -> Bool {
        return guestsSelected.contains(user)
    }
}
extension CreateEventGuestModalViewController {
    @objc func handleDone() {
        onGuestsSelected?(guestsSelected)
        dismiss(animated: true)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
}
extension CreateEventGuestModalViewController :
    UITableViewDelegate,
        UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersToInvite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: GuestModalTableViewCell.identifier,
            for: indexPath
        ) as? GuestModalTableViewCell
        
        let cellUser = usersToInvite[indexPath.row]
        cell?.setupCell(with: cellUser)
        
        let isSelected = isSelected(cellUser)
        cell?.selectToogleCell(isSelected)
        if(isSelected){
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            cell?.isSelected = isSelected
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? GuestModalTableViewCell{
            cell.selectToogleCell(true)
        }
        guestsSelected.append(usersToInvite[indexPath.row])
        print("Guests list \(guestsSelected.map{$0.name})")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? GuestModalTableViewCell{
            cell.selectToogleCell(false)
        }
        let deselected = usersToInvite[indexPath.row]
        guestsSelected.removeAll { $0.id == deselected.id }
        print("Guests list \(guestsSelected)")
    }
    
}
