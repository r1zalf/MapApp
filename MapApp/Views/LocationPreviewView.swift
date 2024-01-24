//
//  LocationPreviewView.swift
//  MapApp
//
//  Created by Rizal Fahrudin on 23/01/24.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject var vm: LocationViewModel

    var location: Location
    
    var body: some View {
        
        HStack(alignment: .bottom) {
            imageSection
            buttonSection
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        
    }
}

#Preview {
    LocationPreviewView(location: LocationsDataService.locations[1])
}


extension LocationPreviewView {
    
    var imageSection: some View {
        VStack(alignment: .leading) {
            
            if let image = location.imageNames.first {
                Image(image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.all, 7)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            titleSection
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    var titleSection: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.title2.weight(.bold))
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var buttonSection: some View {
        VStack {
            Button{
                vm.sheetLocation = location
            } label: {
                Text("Learn More")
                    .font(.headline)
                    .frame(maxWidth:  125)
            }
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            
            Button{
                vm.nextButtonPressed()
            } label: {
                Text("Next")
                    .font(.headline)
                    .frame(maxWidth: 125)
            }
            .controlSize(.large)
            .buttonStyle(.bordered)
            
        }
    }
}
