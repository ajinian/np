//
//  ViewModel.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/5/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol DisposeBagProvider {
    var disposeBag: DisposeBag { get }
}

protocol ErrorObservableProvider {
    var error: PublishRelay<Error> { get }
}

class ViewModel: DisposeBagProvider, ErrorObservableProvider {
    let disposeBag = DisposeBag()
    let error = PublishRelay<Error>()
}
