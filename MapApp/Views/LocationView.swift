//
//  LocationView.swift
//  MapApp
//
//  Created by Rizal Fahrudin on 21/01/24.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @EnvironmentObject var vm: LocationViewModel
    
    let maxWidthIpad: CGFloat = 700
    var body: some View {
        ZStack {
            Map(
                coordinateRegion: $vm.mapRegion,
                annotationItems: vm.locations
            ) { location in
                MapAnnotation(coordinate: location.coordinates) {
                    LocationAnnotationView()
                        .scaleEffect(location == vm.mapLocation ? 1 : 0.7)
                        .onTapGesture {
                            vm.showNextLocation(location)
                        }
                }
            }.ignoresSafeArea()
            
            HStack {
                ForEach(vm.locations) {
                    if $0 == vm.mapLocation {
                        LocationPreviewView(location: vm.mapLocation)
                            .frame(maxWidth: maxWidthIpad, maxHeight: .infinity, alignment: .bottom)
                            .transition(.move(edge: .trailing))
                    }
                }
            }
                
            header
                .frame(maxWidth: maxWidthIpad, maxHeight: .infinity, alignment: .top)
            
        }.sheet(item: $vm.sheetLocation) { location in
            LocationDetailView(location: location)
        }
    }
}

#Preview {
    LocationView()
        .environmentObject(LocationViewModel())
}


extension LocationView {
    var header: some View {
        VStack() {
            Text("\(vm.mapLocation.name), \(vm.mapLocation.cityName)")
                .font(.title2.weight(.black))
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, maxHeight: 55)
                .overlay(alignment: .leading) {
                    Image(systemName: "arrowshape.down.fill")
                        .font(.headline)
                        .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                        .padding()
                }
                .onTapGesture(perform: vm.updateShowLocationList)
            
            if vm.showLocationList {
                LocationListView()
            }
            
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.3), radius: 20, y: 15)
        .padding()
    }
}
