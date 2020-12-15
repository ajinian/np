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

class IngredientsViewModel: ViewModel, IngredientsFielding {
    
    let pizzas: PizzaCollection
    var pizza: PizzaModel
    var collectionCells: [IngredientCollectionViewCell]
    let collectionViewItems = BehaviorRelay<[IngredientCollectionViewCell]>(value: [])
    let addToCartButtonTitle = BehaviorRelay<String>(value: "")
    
    init(pizzas: PizzaCollection, index: Int?) {
        self.pizzas = pizzas
        self.pizza = pizzas.pizza(at: index)
        self.collectionCells = []
        collectionCells.append(IngredientCollectionViewCell(pizza: pizza))
        collectionCells.append(IngredientCollectionViewCell(title: "Ingredients"))
        if let ingredients = pizzas.ingredients?.collection {
            for ingredient in ingredients {
                collectionCells.append(IngredientCollectionViewCell(ingredient: ingredient, isIngredientSelected: self.pizza.ingredients.contains(ingredient.id)))
            }
            collectionViewItems.accept(collectionCells)
        }
        
        super.init()
        addToCartButtonTitle.accept("Add to cart (\((total).toStringCurrency))")
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
        if row > 1 {
            collectionCells.removeAll()
            let ingredient = collectionViewItems.value[row].ingredient!
            if pizza.ingredients.contains(ingredient.id) {
                pizza.ingredients.removeAll { (value) -> Bool in
                    value == ingredient.id
                }
            } else {
                pizza.ingredients.append(ingredient.id)
            }
            collectionCells.append(IngredientCollectionViewCell(pizza: pizza))
            collectionCells.append(IngredientCollectionViewCell(title: "Ingredients"))
            pizzas.ingredients?.collection.forEach { item in
                collectionCells.append(IngredientCollectionViewCell(ingredient: item, isIngredientSelected: pizza.ingredients.contains(item.id)))
            }
            collectionViewItems.accept(collectionCells)
            addToCartButtonTitle.accept("Add to cart (\(total.toStringCurrency))")
        }
    }
    
    func addToCart() {
        Cart.shared.add(cartItem: CartItem(name: pizza.name, price: total))
    }
    
    private var total: Double {
        collectionCells.reduce(pizzas.basePrice) { (r, c) -> Double in
            if c.isIngredientSelected ?? false, let ingr = c.ingredient {
                return r + ingr.price
            }
            return r
        }
    }
}

struct IngredientCollectionViewCell {
    
    let pizza: PizzaModel?
    let title: String?
    let ingredient: BasicItemModel?
    let isIngredientSelected: Bool?
    
    init(ingredient: BasicItemModel? = nil, isIngredientSelected:Bool?=false, pizza: PizzaModel? = nil, title: String? = nil) {
        self.ingredient = ingredient
        self.isIngredientSelected = isIngredientSelected
        self.pizza = pizza
        self.title = title
    }
}
