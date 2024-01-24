//
//  LocationViewModel.swift
//  MapApp
//
//  Created by Rizal Fahrudin on 21/01/24.
//

import SwiftUI
import MapKit


class LocationViewModel: ObservableObject {
    
    @Published var locations = [Location]()
    
    // current location
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(mapLocation)
        }
    }
    @Published var mapRegion = MKCoordinateRegion()
    
    @Published var showLocationList = false
    
    @Published var sheetLocation: Location? 
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation =  locations[0]
        updateMapRegion(locations[0])
        
    }
    
    private func updateMapRegion(_ location: Location) {
        mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
    }
    
    
    func updateShowLocationList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func showNextLocation(_ location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonPressed() {
        
        guard let indexNow = locations.firstIndex(where: { $0 == mapLocation }) else {
            return
        }
        
        var nextInt = indexNow + 1
        
        if nextInt == locations.count {
            nextInt = 0
        }
        
        showNextLocation(locations[nextInt])
    }
    
}
