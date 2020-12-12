//
//  IngredientsViewModel.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/9/20.
//

import Foundation
import RxSwift
import RxCocoa
import Nuke
import RxNuke

class IngredientsViewModel: ViewModel {
    
    let basePrice: Double
    var pizza: PizzaModel
    var ingredients:BasicItemCollection
    var collectionCells: [CollectionViewCell]
    let collectionViewItems = BehaviorRelay<[CollectionViewCell]>(value: [])
    
    init(pizza: PizzaModel, basePrice: Double) {
        self.pizza = pizza
        self.basePrice = basePrice
        self.ingredients = BasicItemCollection()
        self.collectionCells = []
    }
    
    func bind() {
        let ingredientsRequest:Observable<BasicItemCollection> = RequestBuilder(session: Session(), api: BaseApi())
            .build(paths: ["/ingredients.json"]).asObservable()
        ingredientsRequest.map { [weak self] ingredients -> [CollectionViewCell] in
            if let s = self {
                s.ingredients = ingredients
                s.collectionCells.append(CollectionViewCell(pizza: s.pizza))
                s.collectionCells.append(CollectionViewCell(title: "Ingredients"))
                ingredients.collection.forEach { item in
                    s.collectionCells.append(CollectionViewCell(ingredient: item, isIngredientSelected: s.pizza.ingredients.contains(item.id)))
                }
                return s.collectionCells
            }
            return []
        }.bind(to: collectionViewItems)
        .disposed(by: disposeBag)
    }
    
    var productImage: Observable<UIImage>? {
        if let url = pizza.imageUrl {
            return ImagePipeline.shared.rx.loadImage(with: url).asObservable().catchError { _ in
                .empty()
            }.map { response -> UIImage in
                response.image
            }
        }
        return nil
    }
    
    func ingredientName(at row: Int) -> Observable<String?> {
        return Observable.create { [weak self] observer in
            guard let s = self else { return Disposables.create() }
            observer.onNext(s.collectionViewItems.value[row].ingredient?.name)
            return Disposables.create()
        }
    }
    
    func ingredientPrie(at row: Int) -> Observable<String?> {
        return Observable.create { [weak self] observer in
            guard let s = self else { return Disposables.create() }
            observer.onNext(s.collectionViewItems.value[row].ingredient?.price.toStringCurrency)
            return Disposables.create()
        }
    }
    
    func isIngredientSelected(at row: Int) -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            guard let s = self else { return Disposables.create()}
            observer.onNext(s.collectionViewItems.value[row].isIngredientSelected ?? false)
            return Disposables.create()
        }
    }
    
    func changeIngredient(at row: Int) {
        collectionCells.removeAll()
        let ingredient = collectionViewItems.value[row].ingredient!
        if pizza.ingredients.contains(ingredient.id) {
            pizza.ingredients.removeAll { (value) -> Bool in
                value == ingredient.id
            }
        } else {
            pizza.ingredients.append(ingredient.id)
        }
        collectionCells.append(CollectionViewCell(pizza: pizza))
        collectionCells.append(CollectionViewCell(title: "Ingredients"))
        ingredients.collection.forEach { item in
            collectionCells.append(CollectionViewCell(ingredient: item, isIngredientSelected: pizza.ingredients.contains(item.id)))
        }
        collectionViewItems.accept(collectionCells)
    }
}

class CollectionViewCell {
    
    let pizza: PizzaModel?
    let title: String?
    
    var ingredient: BasicItemModel?
    var isIngredientSelected: Bool?
    
    init(ingredient: BasicItemModel? = nil, isIngredientSelected:Bool?=false, pizza: PizzaModel? = nil, title: String? = nil) {
        self.ingredient = ingredient
        self.isIngredientSelected = isIngredientSelected
        self.pizza = pizza
        self.title = title
    }
}
