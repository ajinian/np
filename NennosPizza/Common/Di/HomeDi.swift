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
    init(mockMode: Bool=false) {
        super.init()
        register(type: HomeViewModel.self) { _ in
            let di: DataRequesting = mockMode ? MockRequestDi() : ApiRequestDi()
            return HomeViewModel(di: di)
        }
    }
}

extension HomeDi: HomeFieldingViewModeling {
    var viewModel: HomeFieldingViewModel {
        resolve(type: HomeViewModel.self)!
    }
}
