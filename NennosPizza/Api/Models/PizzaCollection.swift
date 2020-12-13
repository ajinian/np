//
//  PizzaCollection.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/5/20.
//

import Foundation

struct PizzaCollection: Codable {
    var basePrice: Double
    var pizzas: [PizzaModel]
    
    var ingredients: BasicItemCollection?
    var drinks: BasicItemCollection?
    
    init() {
        basePrice = 0
        pizzas = []
    }
    
    func price(at index: Int) -> Double {
        guard ingredients != nil else { return basePrice }
        let pizza = pizzas[index]
        var priceArray = [Double]()
        pizza.ingredients.forEach { ingredientId in
            if let ingredient = ingredients?.collection.first(where: { m -> Bool in
                m.id == ingredientId
            }) {
                priceArray.append(ingredient.price)
            }
        }
        return priceArray.reduce(basePrice) { (r, p) -> Double in
            r + p
        }
    }
    
    func ingredientNames(at index: Int) -> String {
        guard ingredients != nil else { return "" }
        let pizza = pizzas[index]
        var namesArray = [String]()
        pizza.ingredients.forEach { ingredientId in
            if let ingredient = ingredients?.collection.first(where: { model -> Bool in
                model.id == ingredientId
            }) {
                namesArray.append(ingredient.name)
            }
        }
        return namesArray.joined(separator: ", ")
    }
    
    func pizza(at index: Int?) -> PizzaModel {
        if let index = index {
            return pizzas[index]
        }
        return PizzaModel(ingredients: [], name: "Custom Pizza", imageUrl: nil)
    }
    
    mutating func add(pizza: PizzaModel) {
        pizzas.append(pizza)
    }
}
