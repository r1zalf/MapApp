//
//  LocationAnnotationView.swift
//  MapApp
//
//  Created by Rizal Fahrudin on 24/01/24.
//

import SwiftUI

struct LocationAnnotationView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "map.circle")
                .resizable()
                .scaledToFit()
                .background(.white)
                .frame(width: 50, height: 50)
                .foregroundStyle(.accent)
                .font(.headline)
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .foregroundStyle(.accent)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -7)
        }
        .padding(.bottom, 60)
    }
}

#Preview {
    LocationAnnotationView()
}
