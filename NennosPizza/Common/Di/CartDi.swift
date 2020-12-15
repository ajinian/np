//
//  CartDi.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/15/20.
//

import Foundation

typealias CartFieldingViewModel = ViewModel & CartFielding

protocol CartFieldingViewModeling {
    var viewModel: CartFieldingViewModel { get }
}

class CartDi: Di {
    override init() {
        super.init()
        register(type: CartViewModel.self) { _ in
            CartViewModel()
        }
    }
}

extension CartDi: CartFieldingViewModeling {
    var viewModel: CartFieldingViewModel {
        resolve(type: CartViewModel.self)!
    }
}
