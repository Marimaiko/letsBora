import UIKit

class CreateEventViewController: UIViewController {
    
    var screen: CreateEventView?
    
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
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
    }
}
extension CreateEventViewController: CreateEventViewProtocol{
    func didTapCreateEventButton() {
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
        
        
        print("create button tapped")
        
    }
    func didTapInviteButton() {
        print("invite button tapped")
    }
    
    func didTapDraftButton() {
        print("draft button tapped")
    }
    
    
}
//MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    CreateEventViewController()
})



