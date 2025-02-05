//
//  MapView.swift
//  CountryFoodApp
//
//  Created by Edward Gasparian on 01.02.2025.
//

import SwiftUI
import MapKit

struct DishMapView: View {
    
    let dishes = DishDecoder()
    
    @State var position: MapCameraPosition
    @State var satelite = false
    
    var body: some View {
        Map(position: $position) {
            
            ForEach(dishes.dishModel) { dish in
                Annotation(dish.dish, coordinate: dish.location) {
                    Image(dish.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                        .clipShape(.circle)
                        .shadow(color: .black, radius: 7)
                        .shadow(color: .white, radius: 2)
                        
                }
            }
        }
        .mapStyle(satelite ?
            .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satelite.toggle()
            } label: {
                Image(systemName: satelite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .symbolEffect(.breathe)
                    .shadow(radius: 3)
            }
            
            .padding()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    DishMapView(position: .camera(MapCamera(
        centerCoordinate:
            DishDecoder().dishModel[0].location,
                                        distance: 1000,
                                        heading:250,
                                        pitch: 80)))
    .preferredColorScheme(.dark)
}
