import UIKit

// event
let eventRepository = FirestoreEventRepository()

Task{
    do {
        var events = try await eventRepository.retrieveAll()
        for event in events {
            print(event)
            print()
        }
    } catch {
        print(error)
    }
}
