//
//  Request.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/15/20.
//

import Foundation
import RxSwift

class Request<T: Codable> {
    static func fetch(paths: [String]) -> Observable<T> {
        return RequestBuilder(session: Session(), api: BaseApi())
            .build(paths: paths)
            .asObservable()
    }
}
