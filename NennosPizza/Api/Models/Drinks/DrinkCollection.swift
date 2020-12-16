//
//  DrinkCollection.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/16/20.
//

import Foundation

struct DrinkCollection: Codable {
    
    var drinks: [DrinkModel]
    
    init() {
        drinks = []
    }
    
    init(from decoder: Decoder) throws {
        drinks = []
        do {
            var container = try decoder.unkeyedContainer()
            while !container.isAtEnd {
                if let item = try? container.decode(DrinkModel.self) {
                    drinks.append(item)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func drink(with id: Int) -> DrinkModel? {
        drinks.first { m -> Bool in
            m.id == id
        }
    }
}
