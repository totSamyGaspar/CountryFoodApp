//
//  DishesModel.swift
//  CountryFoodApp
//
//  Created by Edward Gasparian on 27.01.2025.
//
import SwiftUI
import MapKit

struct DishesModel: Decodable, Identifiable {
    let id: Int
    let country: String
    let dish: String
    let kcal: String
    let latitude: Double
    let longitude: Double
    let link: String
    let description: String
    let videoID: String
    
    var image: String {
        country.lowercased()
    }
    var flag: String {
        country.lowercased() + "f"
    }
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
