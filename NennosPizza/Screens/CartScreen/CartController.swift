//
//  CartController.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/12/20.
//

import UIKit

class CartController: ViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: CartViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart"
        collectionView.delegate = self
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
