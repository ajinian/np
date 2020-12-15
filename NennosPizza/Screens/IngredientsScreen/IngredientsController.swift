//
//  IngredientsController.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/9/20.
//

import UIKit
import RxSwift
import RxCocoa

protocol IngredientsFielding {
    var pizza: PizzaModel { get }
    var collectionViewItems: BehaviorRelay<[IngredientCollectionViewCell]> { get }
    var productImage: Observable<UIImage>? { get }
    var addToCartButtonTitle: BehaviorRelay<String> { get }
    func ingredientName(at row: Int) -> Observable<String?>
    func ingredientPrie(at row: Int) -> Observable<String?>
    func isIngredientSelected(at row: Int) -> Observable<Bool>
    func changeIngredient(at row: Int)
    func addToCart()
}

class IngredientsController: ViewController {
    
    var viewModel: IngredientsFieldingViewModel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.pizza.name
        collectionView.delegate = self
        viewModel.collectionViewItems.bind(to: collectionView.rx.items) { (collectionView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            switch(row) {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientsHeaderCell", for: indexPath) as! IngredientsHeaderCell
                if let imageRequest = self.viewModel.productImage {
                    imageRequest.bind(to: cell.pizzaImage.rx.image).disposed(by: self.viewModel.disposeBag)
                }
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientsTitleCell", for: indexPath)
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientCell", for: indexPath) as! IngredientCell
                self.viewModel.ingredientName(at: row).bind(to: cell.name.rx.text).disposed(by: self.viewModel.disposeBag)
                self.viewModel.ingredientPrie(at: row).bind(to: cell.price.rx.text).disposed(by: self.viewModel.disposeBag)
                self.viewModel.isIngredientSelected(at: row).bind(to: cell.checkbox.rx.isChecked).disposed(by: self.viewModel.disposeBag)
                return cell
            }
        }
        .disposed(by: viewModel.disposeBag)
        
        collectionView.rx.itemSelected.subscribe { index in
            self.viewModel.changeIngredient(at: index.row)
        }.disposed(by: viewModel.disposeBag)
        
        addToCartButton.rx.tap.subscribe { _ in
            self.viewModel.addToCart()
            NotificationBanner.show("Added to cart")
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.addToCartButtonTitle.bind(to: addToCartButton.rx.title(for: .normal))
            .disposed(by: viewModel.disposeBag)
    }
}

extension IngredientsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        switch(indexPath.row) {
        case 0:
            return CGSize(width: collectionViewSize, height: collectionViewSize - 25)
        case 1:
            return CGSize(width: collectionViewSize, height: 55)
        default:
            return CGSize(width: collectionViewSize, height: 65)
        }
    }
}
