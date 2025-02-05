//
//  OneDishDetail.swift
//  CountryFoodApp
//
//  Created by Edward Gasparian on 27.01.2025.
//

import SwiftUI
import WebKit
import MapKit

struct OneDishDetail: View {
    let oneDish: DishesModel
    
    @State var position: MapCameraPosition
    @Namespace var namespace
    var body: some View {

        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(oneDish.flag)
                    .resizable()
                    .scaledToFit()

                Image(oneDish.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90)
                    .shadow(color: .black, radius: 10)
                    .clipShape(.capsule)
                    .offset(y: 90)
                    .padding()
                    //.border(.blue)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                // Заголовок с названием блюда
                Text(oneDish.dish)
                    .font(.title)
                    .fontWeight(.bold)
                
                // Основное описание блюда
                Text(oneDish.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 15)
                Text("Recepie:")
                    .font(.title3)
                YouTubeView(videoID: oneDish.videoID)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                VStack(alignment: .leading) {
                    // Current Location
                    Text("Where to find:")
                        .font(.title3)
                    NavigationLink {
                        DishMapView(position: .camera(MapCamera(
                            centerCoordinate:
                                oneDish.location,
                            distance: 1000,
                            heading:250,
                            pitch: 80)))
                        .navigationTransition(.zoom(sourceID: 1, in: namespace))
                    } label: {
                        Map(position: $position) {
                            Annotation(oneDish.dish, coordinate: oneDish.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                        }
                        .matchedTransitionSource(id: 1, in: namespace)
                        .frame(height: 125)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    Text("Read more:")
                        .font(.caption)
                        .padding(.top, 15)
                    Link(oneDish.link, destination: URL(string: oneDish.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                        .padding(.bottom, 15)
                }
            }
            .padding()
      
        }
        
        .ignoresSafeArea()
        .toolbarBackground(Color.white.opacity(0.1), for: .navigationBar)
        .preferredColorScheme(.dark)
    }
    }


#Preview {
    let testDish = DishesModel(
        id: 1,
        country: "Germany",
        dish: "Currywurst",
        kcal: "300",
        latitude: 52.5200,
        longitude: 13.4050,
        link: "https://en.wikipedia.org/wiki/Currywurst",
        description: "A popular German street food consisting of sausage with curry ketchup.",
        videoID: "OxvCK7eUMfw"
    )
    NavigationStack {
        OneDishDetail(oneDish: testDish, position: .camera(MapCamera(centerCoordinate: testDish.location, distance: 30000)))
    }
}
