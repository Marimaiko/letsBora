import UIKit
import FSCalendar

class CreateEventViewController: UIViewController {

    private let createEventView = CreateEventView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(createEventView)
        createEventView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createEventView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            createEventView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            createEventView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            createEventView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


