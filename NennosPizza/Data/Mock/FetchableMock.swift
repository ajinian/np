//
//  FileSession.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/17/20.
//

import Foundation
import RxSwift

class FetchableMock<T: Model>: Fetchable {
    func fetch(params: Any?) -> Observable<T> {
        return Observable.create { observer in
            if let filename = params as? String, let filepath = Bundle.main.path(forResource: filename, ofType: "json") {
                guard let data = try? String(contentsOfFile: filepath).data(using: .utf8) else { return Disposables.create() }
                let decoder = JSONDecoder()
                guard let model = try? decoder.decode(T.self, from: data) else { return Disposables.create() }
                observer.onNext(model)
            }
            return Disposables.create()
        }
    }
}
