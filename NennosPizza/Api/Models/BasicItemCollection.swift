//
//  BasicItemCollection.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/5/20.
//

import Foundation

struct BasicItemCollection: Codable {
    
    var collection: [BasicItemModel]
    
    init() {
        collection = []
    }
    
    init(from decoder: Decoder) throws {
        collection = []
        do {
            var container = try decoder.unkeyedContainer()
            while !container.isAtEnd {
                if let item = try? container.decode(BasicItemModel.self) {
                    collection.append(item)
                }
            }
        } catch {
            print(error)
        }
    }
}
