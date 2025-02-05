//
//  DishDecoder.swift
//  CountryFoodApp
//
//  Created by Edward Gasparian on 27.01.2025.
//

import Foundation

class DishDecoder: ObservableObject {

    var dishModel: [DishesModel] = []
    
    init() {
        decodeDishData()
    }
    
    func decodeDishData() {
        
        if let url = Bundle.main.url(forResource: "CountryListData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                dishModel = try decoder.decode([DishesModel].self, from: data)
            } catch {
                print("Error loading JSON file: \(error)")
            }
        }
    }
    
    // searchbar function
    
    func search(for searchTerm: String) -> [DishesModel] {
        if searchTerm.isEmpty {
            return dishModel
        } else {
            return dishModel.filter { dish in
                dish.dish.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }

    // sorting by kcal or name
    
    func sort(by alphabetical: Bool) {
        dishModel.sort { (dish1, dish2) -> Bool in
            if alphabetical {
                return dish1.dish.lowercased() < dish2.dish.lowercased()
            } else {
                return Int(dish1.kcal) ?? 0 < Int(dish2.kcal) ?? 0
            }
        }
    }
}

