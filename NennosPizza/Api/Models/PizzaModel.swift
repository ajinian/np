//
//  PizzaModel.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/5/20.
//

import Foundation

struct PizzaModel: Codable {
    var ingredients: Array<Int>
    var name: String
    var imageUrl: URL?
    
    var mappedIngredients: [BasicItemModel]?
    
    var ingredientNames: String? {
        if let mappedIngredients = mappedIngredients {
            return mappedIngredients.map { model -> String in
                model.name
            }
            .joined(separator: ", ")
        }
        return nil
    }
    
    var price: Double {
        if let mappedIngredients = mappedIngredients {
            return mappedIngredients.reduce(0) { (r, m) -> Double in
                r + m.price
            }
        }
        return 0
    }
}
