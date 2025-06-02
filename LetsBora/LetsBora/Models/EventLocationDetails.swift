//
//  EventLocation.swift
//  LetsBora
//
//  Created by Joel Lacerda on 02/06/25.
//

import Foundation
import CoreLocation
enum EventLocationDetailsKeys{
    static let collectionName = "eventLocationDetails" // maybe will not be used
    static let name = "name"
    static let addressKey = "address"
    static let latitudeKey = "latitude"
    static let longitudeKey = "longitude"
}
struct EventLocationDetails: Codable { // Codable se você salva rascunhos
    let name: String?
    let address: String?
    let latitude: Double
    let longitude: Double

    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    // Texto para exibição na UI (ex: no CustomContainer)
    var displayString: String {
        if let address = address, !address.isEmpty {
            return address
        }
        // Fallback para coordenadas se nome e endereço não estiverem disponíveis
        return String(format: "Lat: %.4f, Lon: %.4f", latitude, longitude)
    }

    init(name: String? = nil, address: String? = nil, latitude: Double, longitude: Double) {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(name: String? = nil, address: String? = nil, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.address = address
        self.latitude = coordinates.latitude
        self.longitude = coordinates.longitude
    }
    
    init?(from data: [String:Any] ) {
        guard let latitude = data[EventLocationDetailsKeys.latitudeKey] as? Double,
              let longitude = data[EventLocationDetailsKeys.longitudeKey] as? Double
        else { return nil }
        
        self.latitude = latitude
        self.longitude = longitude

        
        if let address = data[EventLocationDetailsKeys.addressKey] as? String {
            self.address = address
        }else {
            self.address = nil
        }
        if let name = data[EventLocationDetailsKeys.name] as? String {
            self.name = name
        }else {
            self.name = nil
        }
    }
    
    var toDict: [String:Any] {
        let dict: [String:Any] = [
            EventLocationDetailsKeys.name: name ?? "",
            EventLocationDetailsKeys.addressKey: address ?? "",
            EventLocationDetailsKeys.latitudeKey: latitude,
            EventLocationDetailsKeys.longitudeKey: longitude
        ]
        return dict
    }
    
}
