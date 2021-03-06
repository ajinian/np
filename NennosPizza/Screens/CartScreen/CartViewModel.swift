//
//  CartViewModel.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/12/20.
//

import Foundation
import RxSwift
import RxCocoa

class CartViewModel: ViewModel, CartFielding {
    
    func remove(at index: Int) {
        Cart.shared.remove(pizza: index)
    }
    
    func name(at index: Int) -> Observable<String?> {
        Observable.create{ observer in
            observer.onNext(Cart.shared.cartItems[index].name)
            return Disposables.create()
        }
    }
    
    func price(at index: Int) -> Observable<String?> {
        Observable.create {observer in
            observer.onNext(Cart.shared.cartItems[index].price.toStringCurrency)
            return Disposables.create()
        }
    }
    
    var total: Observable<String?> {
        return Cart.shared.total.map { total -> String in
            "Checkout (\(total.toStringCurrency))"
        }
    }
}
