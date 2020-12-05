//
//  HomeViewModel.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/5/20.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ViewModel {
    
    let pizzas: BehaviorRelay<PizzaCollection> = BehaviorRelay(value: PizzaCollection())
    let ingredients: BehaviorRelay<BasicItemCollection> = BehaviorRelay(value: BasicItemCollection())
    let pizzasWithIngredients: BehaviorRelay<PizzaCollection> = BehaviorRelay(value: PizzaCollection())
    let session = Session()
    let pizzasApi = BaseApi()
    let ingredientsApi = BaseApi()
    
    func load() {
        RequestBuilder(session: session, api: pizzasApi)
            .build(paths: ["/pizzas.json"])
            .asObservable()
            .bind(to: pizzas)
            .disposed(by: disposeBag)
        
        RequestBuilder(session: session, api: ingredientsApi)
            .build(paths: ["/ingredients.json"])
            .asObservable()
            .bind(to: ingredients)
            .disposed(by: disposeBag)
        
        Observable.zip(pizzas, ingredients).map { (p, i) -> PizzaCollection in
            var tempPizzas = PizzaCollection()
            tempPizzas.basePrice = p.basePrice
            for (pi, pizza) in p.pizzas.enumerated() {
                tempPizzas.pizzas.append(pizza)
                tempPizzas.pizzas[pi].mappedIngredients = [BasicItemModel]()
                for id in pizza.ingredients {
                    if let item = i.item(with: id) {
                        tempPizzas.pizzas[pi].mappedIngredients?.append(item)
                    }
                }
            }
            return tempPizzas
        }
        .bind(to: pizzasWithIngredients)
        .disposed(by: disposeBag)
        
    }
}
