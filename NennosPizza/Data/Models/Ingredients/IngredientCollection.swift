//
//  IngredientCollection.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/16/20.
//

import Foundation

struct IngredientCollection: Codable {
    
    var ingredients: [IngredientModel]
    
    init() {
        ingredients = []
    }
    
    init(from decoder: Decoder) throws {
        ingredients = []
        do {
            var container = try decoder.unkeyedContainer()
            while !container.isAtEnd {
                if let item = try? container.decode(IngredientModel.self) {
                    ingredients.append(item)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func ingredient(with id: Int) -> IngredientModel? {
        ingredients.first { m -> Bool in
            m.id == id
        }
    }
}
