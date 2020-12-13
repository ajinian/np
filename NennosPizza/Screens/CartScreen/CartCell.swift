//
//  CartCell.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/12/20.
//

import UIKit
import RxSwift

class CartCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var viewModel: CartViewModel!
    var index: Int!
    
    let disposeBag = DisposeBag()
    
    func load(viewModel: CartViewModel, index: Int) {
        self.viewModel = viewModel
        self.index = index
        viewModel.name(at: index).bind(to: nameLabel.rx.text).disposed(by: viewModel.disposeBag)
        viewModel.price(at: index).bind(to: priceLabel.rx.text).disposed(by: viewModel.disposeBag)
    }
    @IBAction func deleteTapped(_ sender: Any) {
        viewModel.remove(at: index)
    }
}
