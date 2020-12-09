//
//  CartModel.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/8/20.
//

import Foundation
import RxSwift
import RxCocoa

class Cart {
    
    static let shared = Cart()
    
    private var pizzas: PizzaCollection
    private var drinks: BasicItemCollection
    
    var items: PublishSubject<(PizzaCollection, BasicItemCollection, Int)>
    
    init() {
        pizzas = PizzaCollection()
        drinks = BasicItemCollection()
        items = PublishSubject()
    }
    
    func add(pizza: PizzaModel) {
        pizzas.add(pizza: pizza)
        emit()
        print(pizzas)
    }
    
    private func emit() {
        items.onNext((pizzas, drinks, pizzas.pizzas.count + drinks.collection.count))
    }
}
