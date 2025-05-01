import UIKit

class CreateEventViewController: UIViewController {

    var screen: CreateEventView?
    
    override func loadView() {
        screen = CreateEventView()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
    }
}

//MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    CreateEventViewController()
})



