//
//  ViewController.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/4/20.
//

import UIKit
import RxSwift
import RxCocoa

class HomeController: ViewController, IngredientsRoute, CartRoute {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var customPizzaButton: UIButton!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nenno's Pizza"
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
        
        button.rx.tap.subscribe { [weak self] _ in
            guard let s = self else { return }
            s.showCart(viewModel: CartViewModel())
            
        }.disposed(by: viewModel.disposeBag)
        
        Cart.shared.items.map { (_, _, numItems) in String(numItems) }
        .bind(to: button.badgeLabel.rx.text)
            .disposed(by: viewModel.disposeBag)
        
        collectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            if let s = self {
                s.showIngredients(viewModel: IngredientsViewModel(pizzas: s.viewModel.pizzas.value, index: indexPath.row))
            }
        }).disposed(by: viewModel.disposeBag)
        
        customPizzaButton.rx.tap.subscribe { [weak self] _ in
            guard let s = self else { return }
            s.showIngredients(viewModel: IngredientsViewModel(pizzas: s.viewModel.pizzas.value, index: nil))
        }.disposed(by: viewModel.disposeBag)
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize, height: collectionViewSize - 25)
    }
}
