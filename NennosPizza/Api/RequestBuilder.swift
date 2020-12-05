//
//  RequestBuilder.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/4/20.
//

import Foundation

import RxSwift

class RequestBuilder {
    
    private let session: SessionProtocol
    private let api: ApiProtocol
    private var request: URLRequest
    
    init(session: SessionProtocol, api: ApiProtocol) {
        self.session = session
        self.api = api
        request = URLRequest(url: api.baseUrl)
        request.httpMethod = api.httpMethod.rawValue
        request.cachePolicy = api.cachePolicy
    }
    
    func build<T: Codable>(paths: [String]? = nil) -> Single<T> {
        return Single<T>.create { single in
            self.setPaths(paths: paths)
            let task = self.session.apiSession.dataTask(with: self.request) { (data, response, error) in
                print(self.request.url?.absoluteString ?? "")
                if let error = error {
                    print(error)
                    single(.error(error))
                    return
                }
                let decoder = JSONDecoder()
                guard let data = data, let model = try? decoder.decode(T.self, from: data) else { return }
                single(.success(model))
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
    
    func build(url: URL? = nil) -> Single<Data> {
        setUrl(url: url)
        return Single<Data>.create { single in
            let task = self.session.apiSession.dataTask(with: self.request) { (data, response, error) in
                print(self.request.url?.absoluteString ?? "")
                if let error = error {
                    single(.error(error))
                    return
                }
                guard let data = data else { return }
                single(.success(data))
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
    
    private func setPaths(paths: [String]?) {
        if let paths = paths {
            paths.forEach { path in
                self.request.url?.appendPathComponent(path)
            }
        }
    }
    
    private func setUrl(url: URL?) {
        if let url = url {
            request.url = url
        }
    }
}
