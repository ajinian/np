//
//  Request.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/15/20.
//

import Foundation
import RxSwift

class Request<T: Codable> {
    static func fetch(session: SessionProtocol, api: ApiProtocol, paths: [String]) -> Observable<T> {
        return RequestBuilder(session: session, api: api)
            .build(paths: paths)
            .asObservable()
    }
}
