//
//  Router.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/9/20.
//

import UIKit

protocol HomeRoute {
    func showHome(di: HomeFieldingViewModeling, window: UIWindow?)
}

protocol IngredientsRoute {
    func showIngredients(viewModel: IngredientsViewModel)
}

protocol CartRoute {
    func showCart(viewModel: CartViewModel)
}

protocol DrinksRoute {
    func showDrinks(viewModel: DrinksViewModel)
}

extension HomeRoute where Self: SceneDelegate {
    func showHome(di: HomeFieldingViewModeling, window: UIWindow?) {
        if let navigationController = window?.rootViewController as? UINavigationController {
            if let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeController") as? HomeController {
                controller.viewModel = HomeDi().viewModel
                navigationController.viewControllers = [controller]
            }
        }
    }
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
