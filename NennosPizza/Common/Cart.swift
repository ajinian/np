//
//  CartModel.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/8/20.
//

import Foundation
import RxSwift
import RxCocoa

class Cart {
    
    static let shared = Cart()
    
    var cartItems: [CartItem]
    
    var items: BehaviorRelay<[CartItem]>
    var count: BehaviorRelay<Int>
    var total: BehaviorRelay<Double>
    
    init() {
        cartItems = []
        items = BehaviorRelay(value: cartItems)
        count = BehaviorRelay(value: 0)
        total = BehaviorRelay(value: 0)
        emit()
    }
    
    func add(cartItem: CartItem) {
        cartItems.append(cartItem)
        emit()
    }
    
    func remove(pizza index: Int) {
        cartItems.remove(at: index)
        emit()
    }
    
    private func emit() {
        items.accept(cartItems)
        count.accept(cartItems.count)
        total.accept(cartItems.reduce(0) { r, item -> Double in
            r + item.price
        })
    }
}

struct CartItem {
    let name: String
    let price: Double
}
