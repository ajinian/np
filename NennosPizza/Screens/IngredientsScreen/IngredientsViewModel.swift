//
//  IngredientsViewModel.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/9/20.
//

import Foundation
import RxSwift
import RxCocoa

class IngredientsViewModel: ViewModel {
    
    private let pizza: PizzaModel
    private let basePrice: Double
    let ingredients = BehaviorRelay<BasicItemCollection>(value: BasicItemCollection())
    let collectionViewItems = PublishSubject<[CollectionViewCell]>()
    
    init(pizza: PizzaModel, basePrice: Double) {
        self.pizza = pizza
        self.basePrice = basePrice
    }
    
    func bind() {
        let ingredientsRequest:Observable<BasicItemCollection> = RequestBuilder(session: Session(), api: BaseApi())
            .build(paths: ["/ingredients.json"]).asObservable()
        ingredientsRequest.map { [weak self] ingredients -> [CollectionViewCell] in
            var items:[CollectionViewCell] = []
            if let s = self {
                let headerCell = CollectionViewCell(pizza: s.pizza)
                let titleCell = CollectionViewCell(title: "Ingredients")
                items.append(headerCell)
                items.append(titleCell)
                ingredients.collection.forEach { item in
                    items.append(CollectionViewCell(ingredient: item))
                }
            }
            return items
        }.bind(to: collectionViewItems)
        .disposed(by: disposeBag)
    }
}

struct CollectionViewCell {
    
    let ingredient: BasicItemModel?
    let pizza: PizzaModel?
    let title: String?
    
    init(ingredient: BasicItemModel? = nil, pizza: PizzaModel? = nil, title: String? = nil) {
        self.ingredient = ingredient
        self.pizza = pizza
        self.title = title
    }
}
