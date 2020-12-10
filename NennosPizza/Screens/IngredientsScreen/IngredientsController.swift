//
//  IngredientsController.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/9/20.
//

import UIKit
import RxSwift

class IngredientsController: UIViewController {
    
    var viewModel: IngredientsViewModel!
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        viewModel.collectionViewItems.bind(to: collectionView.rx.items) { (collectionView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientsHeaderCell", for: indexPath)
            return cell
        }
        .disposed(by: viewModel.disposeBag)
        viewModel.bind()
    }
}

extension IngredientsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize, height: collectionViewSize - 25)
    }
}
