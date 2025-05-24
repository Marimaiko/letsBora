import UIKit

class CreateEventViewController: UIViewController {
    
    var screen: CreateEventView?
    var viewModel: CreateEventViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func loadView() {
        screen = CreateEventView()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate(delegate: self)
        viewModel = CreateEventViewModel()
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
    }
}
extension CreateEventViewController: CreateEventViewProtocol{
    func didTapCreateEventButton() {
        print("create button tapped")
        
        guard let name = screen?.nameEventTextField.text
        else { return }
        
        guard let description = screen? .descriptionEventTextView .text
        else { return }
        
        guard let date = screen?.calendar.date
        else { return }
        
        guard let time = screen?.timePicker.date
        else { return }
        
        let location = "Local Default"
        let category = "Default"
        
        guard let isPrivate = screen?.switchView.isOn
        else { return }
        
        print("name: \(name)")
        print("description: \(description)")
        print("date: \(date)")
        print("time: \(time)")
        print("location \(location)")
        print("category: \(category)")
        print("isPrivate: \(isPrivate)")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateString = formatter.string(from: date)
        
        
        
        var event = Event(
            title: name,
            date: dateString,
            location: location,
            owner: User(name: "defaultUser")
        )
        
        Task{
            await viewModel?.saveEvent(event:event)
        }
        
    }
    func didTapInviteButton() {
        print("invite button tapped")
        Task {
            await viewModel?.fetchUsers()
            guard let usersToInvite = viewModel?.users else {
                return
            }
            print(usersToInvite)
        }
        
    }
    
    func didTapDraftButton() {
        print("draft button tapped")
    }
    
    
}
//MARK: - Preview Profile
#if swift(>=5.9)
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    CreateEventViewController()
})

#endif
