import UIKit

var eventRepository = FirestoreEventRepository()

func fetchEvent(id: String) async -> Event? {
    do {
        return try await eventRepository.retrieve(for: id)
    } catch {
        print("Error fetching event: \(error)")
        return nil
    }
}

var id: String = "90700EDB-5F06-403B-A38D-12F91A68EBAB"

Task{
    var event = await fetchEvent(id: id)
    if let event = event {
        print("Event fetched successfully: \(event)")
    } else {
        print("Failed to fetch event.")
    }
}





