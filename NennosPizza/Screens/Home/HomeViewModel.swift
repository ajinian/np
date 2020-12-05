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
    
    override init() {
        super.init()
        let pizzasRequest: Observable<PizzaCollection> = RequestBuilder(session: Session(), api: BaseApi())
            .build(paths: ["/pizzas.json"])
            .asObservable()
        
        let ingredientsRequest: Observable<BasicItemCollection> = RequestBuilder(session: Session(), api: BaseApi())
            .build(paths: ["/ingredients.json"])
            .asObservable()
        
        Observable.zip(pizzasRequest, ingredientsRequest).map { (p, i) -> PizzaCollection in
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
        .bind(to: pizzas)
        .disposed(by: disposeBag)
    }
}
