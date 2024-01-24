//
//  LocationDetailView.swift
//  MapApp
//
//  Created by Rizal Fahrudin on 24/01/24.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    @EnvironmentObject var vm: LocationViewModel
    
    let location: Location
    
    var body: some View {
        
        ScrollView {
            tabViewImageSection
            mainContentSection
            Divider()
            mapSection
        }
        .padding()
        .background(.ultraThinMaterial)
        .ignoresSafeArea()
    
}
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationViewModel())
}


extension LocationDetailView {
    
    var mapSection: some View {
        Map(
            coordinateRegion: .constant(MKCoordinateRegion(
                center: location.coordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )),
            annotationItems: [location]
        ) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationAnnotationView()
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    var mainContentSection: some View {
        VStack(alignment: .leading, spacing: 13)  {
            Text(location.name)
                .font(.largeTitle.weight(.semibold))
                .foregroundStyle(.primary)
            
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
            
            Divider()
            
            Text(location.description)
                .font(.body)
                .foregroundStyle(.secondary)
            
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .foregroundStyle(.blue)
            }
        }
    }
    
    var tabViewImageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .scaledToFill()
                    .clipped()
            }
        }
        .frame(height: 500)
        .frame(maxWidth: .infinity)
        .tabViewStyle(.page)
        .shadow(radius: 15)
        .overlay {
            Image(systemName: "xmark")
                .resizable()
                .font(.headline)
                .scaledToFit()
                .padding()
                .frame(width: 50, height: 50)
                .background(.ultraThickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .onTapGesture {
                    vm.sheetLocation = nil
                }
        }
    }
}
