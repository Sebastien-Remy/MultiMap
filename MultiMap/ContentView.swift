//
//  ContentView.swift
//  MultiMap
//
//  Created by Sebastien REMY on 22/10/2022.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var searchText = ""
    @State private var locations = [Location]()
    @State private var selectedLocations = Set<Location>()
    
    // London centred region
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    
    var body: some View {
        NavigationView {
            List(locations, selection: $selectedLocations) { location in
                Text(location.name)
                    .tag(location)
            }
            .frame(minWidth: 200)
            VStack {
                HStack {
                    TextField("Search for something…", text: $searchText)
                        .onSubmit (runSearch)
                    Button("Go", action: runSearch)
                }
                .padding([.top, .horizontal])
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
            .onChange(of: selectedLocations) { _ in
                var visibleMap = MKMapRect.null
                
                for location in selectedLocations {
                    let mapPoint = MKMapPoint(location.coordinate)
                    let pointRect = MKMapRect(x: mapPoint.x - 100_000, y: mapPoint.y - 100_000, width: 200_000, height: 200_000)
                    visibleMap = visibleMap.union(pointRect)
                }
                
                var newRegion = MKCoordinateRegion(visibleMap)
                newRegion.span.latitudeDelta *= 1.5
                newRegion.span.longitudeDelta *= 1.5
                region = newRegion
            }
        }
    }
    
    func runSearch() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response else { return }
            guard let item = response.mapItems.first else { return }
            guard let itemName = item.name, let itemLocation = item.placemark.location else { return }
            let newLocation = Location(name: itemName, latitude: itemLocation.coordinate.latitude, longitude: itemLocation.coordinate.longitude)
            
            locations.append(newLocation)
            selectedLocations = [newLocation]
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
