//
//  DrinksCell.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/13/20.
//

import UIKit

class DrinksCell: UICollectionViewCell {
    
    var viewModel: DrinksFieldingViewModel!
    var index: Int!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func load(viewModel: DrinksFieldingViewModel, index: Int) {
        self.viewModel = viewModel
        self.index = index
        viewModel.name(at: index).bind(to: nameLabel.rx.text).disposed(by: viewModel.disposeBag)
        viewModel.price(at: index).bind(to: priceLabel.rx.text).disposed(by: viewModel.disposeBag)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        viewModel.add(at: index)
        NotificationBanner.show("Added to cart")
    }
}
