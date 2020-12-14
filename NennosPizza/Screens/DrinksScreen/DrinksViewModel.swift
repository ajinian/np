//
//  DrinksViewModel.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/13/20.
//

import UIKit
import RxSwift
import RxCocoa

class DrinksViewModel: ViewModel {
    
    let drinks: BehaviorRelay<BasicItemCollection> = BehaviorRelay(value: BasicItemCollection())
    
    override init() {
        super.init()
        let drinksRequest: Observable<BasicItemCollection> = RequestBuilder(session: Session(), api: BaseApi())
            .build(paths: ["/drinks.json"])
            .asObservable()
        drinksRequest.bind(to: drinks).disposed(by: disposeBag)
    }
    
    func name(at index: Int) -> Observable<String?> {
        return Observable.create { [weak self] observer in
            guard let s = self else { return Disposables.create() }
            observer.onNext(s.drinks.value.collection[index].name)
            return Disposables.create()
        }
    }
    
    func price(at index: Int) -> Observable<String?> {
        return Observable.create { [weak self] observer in
            guard let s = self else { return Disposables.create() }
            observer.onNext(s.drinks.value.collection[index].price.toStringCurrency)
            return Disposables.create()
        }
    }
    
    func add(at index: Int) {
        let drink = drinks.value.collection[index]
        Cart.shared.add(cartItem: CartItem(name: drink.name, price: drink.price))
    }
}
