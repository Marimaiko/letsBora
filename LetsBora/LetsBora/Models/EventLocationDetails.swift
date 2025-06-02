//
//  EventLocation.swift
//  LetsBora
//
//  Created by Joel Lacerda on 02/06/25.
//

import Foundation
import CoreLocation

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
        if let name = name, !name.isEmpty {
            return name
        }
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
}
