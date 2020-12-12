//
//  IngredientsController.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/9/20.
//

import UIKit
import RxSwift

class IngredientsController: ViewController {
    
    var viewModel: IngredientsViewModel!
    
    @IBOutlet weak var collectionView: UICollectionView!

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
                return cell
            }
        }
        .disposed(by: viewModel.disposeBag)
        viewModel.bind()
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
