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

extension IngredientsRoute where Self: UIViewController {
    func showIngredients(viewModel: IngredientsViewModel) {
        if let c = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "IngredientsController") as? IngredientsController {
            c.viewModel = viewModel
            self.navigationController?.pushViewController(c, animated: true)
        }
    }
}
