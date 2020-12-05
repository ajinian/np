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
}
