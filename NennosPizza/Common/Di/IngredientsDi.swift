//
//  IngredientsDi.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/15/20.
//

import Foundation

typealias IngredientsFieldingViewModel = ViewModel & IngredientsFielding

protocol IngrediensFieldingViewModeling {
    var viewModel: IngredientsFieldingViewModel { get }
}

class IngredientsDi: Di {
    init(pizzas: PizzaCollection, index: Int?) {
        super.init()
        register(type: IngredientsFieldingViewModel.self) { _ in
            IngredientsViewModel(pizzas: pizzas, index: index)
        }
    }
}

extension IngredientsDi: IngrediensFieldingViewModeling {
    var viewModel: IngredientsFieldingViewModel {
        resolve(type: IngredientsFieldingViewModel.self)!
    }
}
