//
//  DrinksDi.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/15/20.
//

import Foundation

typealias DrinksFieldingViewModel = ViewModel & DrinksFielding

protocol DrinksFieldingViewModeling {
    var viewModel: DrinksFieldingViewModel { get }
}

class DrinksDi: Di {
    override init() {
        super.init()
        register(type: DrinksViewModel.self) { _ in
            DrinksViewModel()
        }
    }
}

extension DrinksDi: DrinksFieldingViewModeling {
    var viewModel: DrinksFieldingViewModel {
        resolve(type: DrinksViewModel.self)!
    }
}
