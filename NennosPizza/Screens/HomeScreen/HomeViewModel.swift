//
//  HomeViewModel.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/5/20.
//

import Foundation
import RxSwift
import RxCocoa
import Nuke
import RxNuke

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
        
        let drinksRequest: Observable<BasicItemCollection> = RequestBuilder(session: Session(), api: BaseApi())
            .build(paths: ["/drinks.json"])
            .asObservable()
        
        Observable.zip(pizzasRequest, ingredientsRequest, drinksRequest).map { (p, i, d) -> PizzaCollection in
            var tempPizzas = PizzaCollection()
            tempPizzas.ingredients = i
            tempPizzas.drinks = d
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
    
    func name(at index: Int) -> Observable<String> {
        return Observable.create { [weak self] subscriber -> Disposable in
            guard let s = self else { return Disposables.create() }
            subscriber.onNext(s.pizzas.value.pizzas[index].name)
            return Disposables.create()
        }
    }
    
    func ingredients(at index: Int) -> Observable<String?> {
        return Observable.create { [weak self] subscriber -> Disposable in
            guard let s = self else { return Disposables.create() }
            subscriber.onNext(s.pizzas.value.pizzas[index].ingredientNames)
            return Disposables.create()
        }
    }
    
    func productImage(at index: Int) -> Observable<UIImage>? {
        if let url = pizzas.value.pizzas[index].imageUrl {
            return ImagePipeline.shared.rx.loadImage(with: url).asObservable().catchError { _ in
                .empty()
            }.map { response -> UIImage in
                response.image
            }
        }
        return nil
    }
    
    func price(at index: Int) -> Observable<String> {
        return Observable.create { [weak self] subscriber -> Disposable in
            guard let s = self else { return Disposables.create() }
            let total = s.pizzas.value.price(at: index)
            subscriber.onNext(total.toStringCurrency)
            return Disposables.create()
        }
    }
    
    func pizza(at index: Int) -> PizzaModel {
        pizzas.value.pizzas[index]
    }
    
    var customPizza: PizzaModel {
        return PizzaModel(ingredients: [], name: "Custom Pizza", imageUrl: nil, mappedIngredients: nil)
    }
    
    var basePrice: Double {
        pizzas.value.basePrice
    }
}
