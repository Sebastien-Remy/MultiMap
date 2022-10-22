//
//  ContentView.swift
//  MultiMap
//
//  Created by Sebastien REMY on 22/10/2022.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    let locations = [
        Location(name: "London", latitude: 51.507222, longitude: -0.1275),
        Location(name: "Glasgow", latitude: 55.8616752, longitude: -4.2546099)
    ]
    
    // London centred
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations) {
            location in MapAnnotation(coordinate: location.coordinate) {
                Text(location.name)
                    .font(.headline)
                    .padding(5)
                    .padding(.horizontal, 5)
                    .background(.black)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            
        }
        .frame(minWidth: 400, minHeight: 400)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
