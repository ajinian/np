//
//  PizzaCollection.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/5/20.
//

import Foundation

struct PizzaCollection: Codable {
    var basePrice: Double = 0
    var pizzas: [PizzaModel] = []
    
    init() {
        basePrice = 0
        pizzas = []
    }
}
