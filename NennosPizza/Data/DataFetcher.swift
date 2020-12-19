//
//  DataFetcher.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/17/20.
//

import Foundation
import RxSwift

protocol Fetchable {
    associatedtype Model
    func fetch(params: Any?) -> Observable<Model>
}
typealias Model = Codable

class DataFetcher<T: Fetchable> {
    static func fetch(fetchable: T, params: Any?=nil) -> Observable<T.Model> {
        return fetchable.fetch(params: params)
    }
}
