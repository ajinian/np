//
//  DrinksController.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/13/20.
//

import UIKit
import RxSwift
import RxCocoa

protocol DrinksFielding {
    var drinks: BehaviorRelay<BasicItemCollection> { get }
    func name(at index: Int) -> Observable<String?>
    func price(at index: Int) -> Observable<String?>
    func add(at index: Int)
}

class DrinksController: UIViewController {
    
    var viewModel: DrinksFieldingViewModel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Drinks"
        collectionView.delegate = self
        viewModel.drinks.map { model -> [BasicItemModel] in
            model.collection
        }.bind(to: collectionView.rx.items) { (collectionView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrinksCell", for: indexPath) as! DrinksCell
            cell.load(viewModel: self.viewModel, index: row)
            return cell
        }.disposed(by: viewModel.disposeBag)
        
    }
}

extension DrinksController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize, height: 75)
    }
}
