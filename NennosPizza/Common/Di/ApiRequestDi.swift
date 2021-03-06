//
//  ApiRequestDi.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/15/20.
//

import Foundation
import RxSwift

protocol DataRequesting {
    var pizzasRequest: Observable<PizzaCollection> { get }
    var ingredientRequest: Observable<IngredientCollection> { get }
    var drinkRequest: Observable<DrinkCollection> { get }
}

class ApiRequestDi: Di {
    override init() {
        super.init()
        register(type: Observable<PizzaCollection>.self) { di -> Observable<PizzaCollection> in
            FetchableApi<PizzaCollection>().fetch(params: ["pizzas.json"])
        }
        register(type: Observable<IngredientCollection>.self) { di -> Observable<IngredientCollection> in
            FetchableApi<IngredientCollection>().fetch(params: ["ingredients.json"])
        }
        register(type: Observable<DrinkCollection>.self) { di -> Observable<DrinkCollection> in
            FetchableApi<DrinkCollection>().fetch(params: ["drinks.json"])
        }
    }
}

extension ApiRequestDi: DataRequesting {
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
