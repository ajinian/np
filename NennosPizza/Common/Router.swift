//
//  Router.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/9/20.
//

import UIKit

protocol IngredientsRoute {
    func showIngredients(viewModel: IngredientsViewModel)
}

protocol CartRoute {
    func showCart(viewModel: CartViewModel)
}

protocol DrinksRoute {
    func showDrinks(viewModel: DrinksViewModel)
}

extension IngredientsRoute where Self: UIViewController {
    func showIngredients(viewModel: IngredientsViewModel) {
        if let c = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "IngredientsController") as? IngredientsController {
            c.viewModel = viewModel
            self.navigationController?.pushViewController(c, animated: true)
        }
    }
}

extension CartRoute where Self: UIViewController {
    func showCart(viewModel: CartViewModel) {
        if let c = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "CartController") as? CartController {
            c.viewModel = viewModel
            self.navigationController?.pushViewController(c, animated: true)
        }
    }
}

extension DrinksRoute where Self: UIViewController {
    func showDrinks(viewModel: DrinksViewModel) {
        if let c = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "DrinksController") as? DrinksController {
            c.viewModel = viewModel
            self.navigationController?.pushViewController(c, animated: true)
        }
    }
}
