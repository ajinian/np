//
//  ViewController.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/4/20.
//

import UIKit
import RxSwift
import RxCocoa

class HomeController: UIViewController, IngredientsRoute {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = HomeViewModel()
    @IBOutlet weak var customPizzaButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedNavigationItemTitle(text: "Nenno's Pizza")
        collectionView.delegate = self
        viewModel.pizzas.map { pizzaCollection -> [PizzaModel] in
            pizzaCollection.pizzas
        }.bind(to: collectionView.rx.items(cellIdentifier: "PizzaCell", cellType: PizzaCell.self)) { (row, element, cell) in
            self.viewModel.name(at: row).bind(to: cell.nameLabel.rx.text).disposed(by: self.viewModel.disposeBag)
            self.viewModel.ingredients(at: row).bind(to: cell.ingredientsLabel.rx.text).disposed(by: self.viewModel.disposeBag)
            self.viewModel.price(at: row).bind(to: cell.priceTagLabel.rx.text).disposed(by: self.viewModel.disposeBag)
            if let imageRequest = self.viewModel.productImage(at: row) {
                imageRequest.bind(to: cell.pizzaImage.rx.image).disposed(by: self.viewModel.disposeBag)
            }
        }.disposed(by: viewModel.disposeBag)
        
        let button = BadgeButton(frame: CGRect(x: 0, y: 0, width: 18, height: 16))
        button.setImage(UIImage(named: "ic_cart_navbar"), for: .normal)
        button.tintColor = UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        let cartButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = cartButton
        
        
        Cart.shared.items.map { (_, _, numItems) in String(numItems) }
        .bind(to: button.badgeLabel.rx.text)
        .disposed(by: viewModel.disposeBag)
        
        collectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            if let s = self {
                let pizza = s.viewModel.pizza(at: indexPath.row)
                let basePrice = s.viewModel.basePrice
                s.showIngredients(viewModel: IngredientsViewModel(pizza: pizza, basePrice: basePrice))
            }
        }).disposed(by: viewModel.disposeBag)
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize, height: collectionViewSize - 25)
    }
}
