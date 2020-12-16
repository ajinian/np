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
    var ingredientRequest: Observable<BasicItemCollection> { get }
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
        register(type: Observable<BasicItemCollection>.self) { di -> Observable<BasicItemCollection> in
            Request.fetch(session: di.resolve(type: Session.self)!, api: di.resolve(type: BaseApi.self)!, paths: ["ingredients.json"])
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
    var ingredientRequest: Observable<BasicItemCollection> {
        resolve(type: Observable<BasicItemCollection>.self)!
    }
}
