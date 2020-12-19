//
//  DrinksViewModel.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/13/20.
//

import UIKit
import RxSwift
import RxCocoa

class DrinksViewModel: ViewModel, DrinksFielding {
    
    var drinks: BehaviorRelay<DrinkCollection> = BehaviorRelay(value: DrinkCollection())
    
    init(di: DataRequesting) {
        super.init()
        di.drinkRequest.bind(to: drinks).disposed(by: disposeBag)
    }
    
    func name(at index: Int) -> Observable<String?> {
        return Observable.create { [weak self] observer in
            guard let s = self else { return Disposables.create() }
            observer.onNext(s.drinks.value.drinks[index].name)
            return Disposables.create()
        }
    }
    
    func price(at index: Int) -> Observable<String?> {
        return Observable.create { [weak self] observer in
            guard let s = self else { return Disposables.create() }
            observer.onNext(s.drinks.value.drinks[index].price.toStringCurrency)
            return Disposables.create()
        }
    }
    
    func add(at index: Int) {
        let drink = drinks.value.drinks[index]
        Cart.shared.add(cartItem: CartItem(name: drink.name, price: drink.price))
    }
}
