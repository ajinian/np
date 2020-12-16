//
//  ApiRequestDi.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/15/20.
//

import Foundation
import RxSwift

protocol ApiRequesting {
    var session: SessionProtocol { get }
    var api: ApiProtocol { get }
    var pizzasRequest: Observable<PizzaCollection> { get }
    var ingredientRequest: Observable<IngredientCollection> { get }
    var drinkRequest: Observable<DrinkCollection> { get }
}

class ApiRequestDi: Di {
    override init() {
        super.init()
        register(type: Session.self) { _ in
            Session()
        }
        register(type: BaseApi.self) { _ in
            BaseApi()
        }
        register(type: Observable<PizzaCollection>.self) { di -> Observable<PizzaCollection> in
            Request.fetch(session: di.resolve(type: Session.self)!, api: di.resolve(type: BaseApi.self)!, paths: ["pizzas.json"])
        }
        register(type: Observable<IngredientCollection>.self) { di -> Observable<IngredientCollection> in
            Request.fetch(session: di.resolve(type: Session.self)!, api: di.resolve(type: BaseApi.self)!, paths: ["ingredients.json"])
        }
        register(type: Observable<DrinkCollection>.self) { di -> Observable<DrinkCollection> in
            Request.fetch(session: di.resolve(type: Session.self)!, api: di.resolve(type: BaseApi.self)!, paths: ["drinks.json"])
        }
    }
}

extension ApiRequestDi: ApiRequesting {
    var session: SessionProtocol {
        resolve(type: Session.self)!
    }
    var api: ApiProtocol {
        resolve(type: BaseApi.self)!
    }
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
