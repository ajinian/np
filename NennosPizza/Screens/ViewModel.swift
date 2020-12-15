//
//  ViewModel.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/5/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol DisposeBagging {
    var disposeBag: DisposeBag { get }
}

protocol ErrorObserving {
    var error: PublishRelay<Error> { get }
}

class ViewModel: DisposeBagging, ErrorObserving {
    let disposeBag = DisposeBag()
    let error = PublishRelay<Error>()
}
