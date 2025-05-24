//
//  MyEventsViewController.swift
//  LetsBora
//
//  Created by Joel Lacerda on 30/04/25.
//

import UIKit

class MyEventsViewController: UIViewController {
    //MARK: Properties
    private let mainView = MyEventsView()
    private var events: [Event] = MockData.pastEvents
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.delegate = self
        configureTableView()
    }
    func configureTableView() {
        mainView.tableView.register(
            EventCardTableViewCell.self,
            forCellReuseIdentifier: EventCardTableViewCell.identifier
        )
        mainView.tableView.dataSource = self
    }

}
extension MyEventsViewController: MyEventsViewDelegate{
    func seeDetailsTapped() {
        let detailVC = EventDetailsViewController()
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}

// MARK: - Table View Delegate
extension MyEventsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return events.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: EventCardTableViewCell.identifier, for: indexPath) as? EventCardTableViewCell
           cell?.setupCell(with: events[indexPath.row], isPast: true)
           return cell ?? UITableViewCell()
       }
}


// MARK: - Preview
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview("Home View Controller", traits: .portrait, body: {
    MyEventsViewController()
})
#endif
