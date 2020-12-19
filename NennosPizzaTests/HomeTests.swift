//
//  NennosPizzaTests.swift
//  NennosPizzaTests
//
//  Created by Arthur Jinian on 12/4/20.
//

import XCTest
@testable import NennosPizza
import RxSwift
import RxTest

class HomeTests: XCTestCase {
    
    var di: HomeDi!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    var viewModel: TestableObserver<HomeViewModel>!

    override func setUpWithError() throws {
        di = HomeDi(mockMode: true)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        viewModel = scheduler.createObserver(HomeViewModel.self)
        Observable
            .just(di.viewModel as! HomeViewModel)
            .bind(to: viewModel)
            .disposed(by: disposeBag)
    }

    override func tearDownWithError() throws {
        di = nil
        scheduler = nil
        disposeBag = nil
        viewModel = nil
    }
    
    func testPizzaName() throws {
        let name = scheduler.createObserver(String.self)
        viewModel.events[0].value.element?.name(at: 0)
            .asDriver(onErrorJustReturn: "")
            .drive(name)
            .disposed(by: disposeBag)
        XCTAssertEqual(name.events[0].value.element, "Margherita")
    }
    
    func testPizzaIngredients() throws {
        let ingredients = scheduler.createObserver(String.self)
        viewModel.events[0].value.element?.ingredients(at: 0)
            .asDriver(onErrorJustReturn: "")
            .drive(ingredients)
            .disposed(by: disposeBag)
        XCTAssertEqual(ingredients.events[0].value.element, "Mozzarella, Tomato Sauce")
    }
    
    func testPizzaTotal() throws {
        let price = scheduler.createObserver(String.self)
        viewModel.events[0].value.element?.price(at: 0)
            .asDriver(onErrorJustReturn: "")
            .drive(price)
            .disposed(by: disposeBag)
        XCTAssertEqual(price.events[0].value.element, "$5.50")
    }
}
