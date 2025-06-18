//
//  MyEventViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 15/06/25.
//
import Foundation

protocol MyEventViewModelDelegate: AnyObject {
    func didUpdateEvents()
    func didFailToLoadEvents(with error: Error)
}

class MyEventViewModel {
    // MARK: - Properties
    private weak var delegate: MyEventViewModelDelegate?
    
    func delegate(_ inject: MyEventViewModelDelegate){
        delegate = inject
    }
    private var eventRepository: EventRepository?
    private(set) var allEvents: [Event] = []{
        didSet {
            processEvents()
            delegate?.didUpdateEvents()
        }
    }
    private(set) var nextEvent: Event?
    private(set) var nextEvents: [Event] = []
    private(set) var pastEvents: [Event] = []
    
    // MARK: - Initializer
    init(eventRepository: EventRepository? = FirestoreEventRepository()) {
        self.eventRepository = eventRepository
    }
    
    // MARK: - Helpers
    private var userId: String? = {
        let user = Utils.getLoggedInUser()
        return user?.id
    }()
    
    // MARK: - Load Events with Closure
    func loadEvents() {
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            do {
                let events = try await self.fetchMyEvents()
                DispatchQueue.main.async {
                    self.allEvents = events
                    print("Events fetched successfully: \(events.count)")
                }
            } catch {
                print("Error fetching events: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.delegate?.didFailToLoadEvents(with: error)
                }
            }
        }
    }
    private func fetchMyEvents() async throws -> [Event] {
          guard let userId = self.userId else {
              print("User ID not found")
              return []
          }
          let query = EventQuery(key: EventKeys.owner, value: userId)
          return try await self.eventRepository?.retrieveEqual(query) ?? []
      }

      private func processEvents() {
          let now = Date()

          // Filter future and past events
          let futureEvents = allEvents.filter { $0.date.toDate() ?? now > now }
          let pastEvents = allEvents.filter { $0.date.toDate() ?? now <= now }

          self.nextEvents = futureEvents
          self.pastEvents = pastEvents
      }
    
}
