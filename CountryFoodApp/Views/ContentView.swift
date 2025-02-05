//
//  ContentView.swift
//  CountryFoodApp
//
//  Created by Edward Gasparian on 26.01.2025.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject var dishes = DishDecoder()
    @State var searchText: String = ""
    @State var alphabetical = false
    
    var filterDishes: [DishesModel] {
        
        dishes.sort(by: alphabetical)
        
        return dishes.search(for: searchText)
    }
    
    var body: some View {
        
        NavigationStack {
            List(filterDishes) { dish in
                NavigationLink {
                    OneDishDetail(oneDish: dish, position: .camera(
                        MapCamera(
                            centerCoordinate:
                                dish.location,
                            distance: 30000))
                    )
                } label: {
                    HStack {
                        // Dish img
                        Image(dish.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90)
                            .clipShape(.capsule)
                            .shadow(color: .black, radius: 3)
                            .padding(.trailing)
                        VStack(alignment: .leading) {
                            // Name
                            Text(dish.dish)
                                .fontWeight(.semibold)
                                .font(.subheadline)
                            // Kcal
                            Text("Callories: \(dish.kcal) / 100g")
                                .font(.caption)
                                .padding(.vertical, 5)
                        }
                        VStack (alignment: .trailing) {
                            Text(dish.country)
                                .font(.caption)
                                .fontWeight(.bold)
                            
                            Image(dish.flag)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 20)
                                .shadow(color: .black, radius: 3)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)  
                    }
                }
            }
            .navigationTitle("Food of Europe")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "fork.knife.circle" : "textformat" )
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
