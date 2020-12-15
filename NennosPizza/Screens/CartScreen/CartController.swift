//
//  CartController.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/12/20.
//

import UIKit
import RxSwift

protocol CartFielding {
    var total: Observable<String?> { get }
    func name(at index: Int) -> Observable<String?>
    func price(at index: Int) -> Observable<String?>
    func remove(at index: Int)
}

class CartController: ViewController, DrinksRoute {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var checkoutButton: UIButton!
    var viewModel: CartFieldingViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart"
        collectionView.delegate = self
        Cart.shared.items.bind(to: collectionView.rx.items) { (collectionView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as! CartCell
            cell.load(viewModel: self.viewModel, index: row)
            return cell
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.total.bind(to: checkoutButton.rx.title(for: .normal))
            .disposed(by: viewModel.disposeBag)
        
        let customButton = UIButton()
        customButton.setImage(UIImage(named: "beverage"), for: .normal)
        customButton.tintColor = .gray
        let rightButton = UIBarButtonItem(customView: customButton)
        self.navigationItem.setRightBarButtonItems([rightButton], animated: true)
        customButton.rx.tap.subscribe { [weak self] _ in
            guard let s = self else { return }
            s.showDrinks(viewModel: DrinksViewModel())
        }.disposed(by: viewModel.disposeBag)
    }
}

extension CartController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize, height: 75)
    }
}
