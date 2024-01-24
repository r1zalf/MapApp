//
//  LocationListView.swift
//  MapApp
//
//  Created by Rizal Fahrudin on 21/01/24.
//

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject var vm: LocationViewModel

    var body: some View {
        List {
            ForEach(vm.locations) { location in
                listItem(location)
                    .onTapGesture {
                        vm.showNextLocation(location)
                    }
            }
            .listRowBackground(Color.clear)
            
        }.listStyle(.plain)
    }
}

#Preview {
    LocationListView()
        .environmentObject(LocationViewModel())
}


extension LocationListView {
    private func listItem(_ location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .frame(width: 55, height: 55)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
