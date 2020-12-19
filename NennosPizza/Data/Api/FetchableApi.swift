//
//  ApiRequestFetcher.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/17/20.
//

import Foundation
import RxSwift

class FetchableApi<T: Model>: Fetchable {
    
    private var request: URLRequest
    private var session: Session
    
    init() {
        request = URLRequest(url: URL(string: "https://doclerlabs.github.io/mobile-native-challenge")!)
        session = Session()
    }
    func fetch(params: Any?) -> Observable<T> {
        return Single<T>.create { single in
            if let p = params as? [String] {
                self.setPaths(paths: p)
            }
            let task = self.session.apiSession.dataTask(with: self.request) { (data, response, error) in
                print(self.request.url?.absoluteString ?? "")
//                if let error = error {
//                    single(.error(error))
//                    return
//                }
                let decoder = JSONDecoder()
                guard let data = data, let model = try? decoder.decode(T.self, from: data) else { return }
                single(.success(model))
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }.asObservable()
    }
    
    private func setPaths(paths: [String]?) {
        if let paths = paths {
            paths.forEach { path in
                self.request.url?.appendPathComponent(path)
            }
        }
    }
}
