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

class HomeViewModel: ViewModel, HomeFielding {
    
    let pizzas: BehaviorRelay<PizzaCollection> = BehaviorRelay(value: PizzaCollection())
    
    override init() {
        super.init()
        let pizzasRequest = Request<PizzaCollection>.fetch(paths: ["/pizzas.json"])
        
        let ingredientsRequest = Request<BasicItemCollection>.fetch(paths: ["/ingredients.json"])
        
        Observable.zip(pizzasRequest, ingredientsRequest).map { (p, i) -> PizzaCollection in
            var tempPizzas = PizzaCollection()
            tempPizzas.ingredients = i
            tempPizzas.basePrice = p.basePrice
            for pizza in p.pizzas{
                tempPizzas.pizzas.append(pizza)
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
            subscriber.onNext(s.pizzas.value.ingredientNames(at: index))
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
}
