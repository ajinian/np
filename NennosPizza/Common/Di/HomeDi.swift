//
//  HomeDi.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/14/20.
//

import Foundation

typealias HomeFieldingViewModel = ViewModel & HomeFielding

protocol HomeFieldingViewModeling {
    var viewModel: HomeFieldingViewModel { get }
}

class HomeDi: Di {
    override init() {
        super.init()
        register(type: HomeViewModel.self) { _ in
            return HomeViewModel(di: ApiRequestDi())
        }
    }
}

extension HomeDi: HomeFieldingViewModeling {
    var viewModel: HomeFieldingViewModel {
        resolve(type: HomeViewModel.self)!
    }
}
