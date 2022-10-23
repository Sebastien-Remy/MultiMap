//
//  Location.swift
//  MultiMap
//
//  Created by Sebastien REMY on 22/10/2022.
//

import MapKit

struct Location: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name
    }

}
