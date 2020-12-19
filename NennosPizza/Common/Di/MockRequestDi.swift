//
//  MockRequestDi.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/18/20.
//

import Foundation
import RxSwift

class MockRequestDi: Di {
    override init() {
        super.init()
        register(type: Observable<PizzaCollection>.self) { di -> Observable<PizzaCollection> in
            FetchableMock<PizzaCollection>().fetch(params: "pizzas")
        }
        register(type: Observable<IngredientCollection>.self) { di -> Observable<IngredientCollection> in
            FetchableMock<IngredientCollection>().fetch(params: "ingredients")
        }
        register(type: Observable<DrinkCollection>.self) { di -> Observable<DrinkCollection> in
            FetchableMock<DrinkCollection>().fetch(params: "drinks")
        }
    }
}

extension MockRequestDi: DataRequesting {
    var pizzasRequest: Observable<PizzaCollection> {
        resolve(type: Observable<PizzaCollection>.self)!
    }
    var ingredientRequest: Observable<IngredientCollection> {
        resolve(type: Observable<IngredientCollection>.self)!
    }
    var drinkRequest: Observable<DrinkCollection> {
        resolve(type: Observable<DrinkCollection>.self)!
    }
}
