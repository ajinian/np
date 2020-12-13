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
        pizzas[index].price + basePrice
    }
    
    mutating func add(pizza: PizzaModel) {
        pizzas.append(pizza)
    }
}
