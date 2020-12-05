//
//  BaseApi.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/4/20.
//

import Foundation

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}

protocol ApiProtocol {
    var baseUrl: URL { get }
    var httpMethod: HttpMethod { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

class BaseApi: ApiProtocol {
    var baseUrl = URL(string: "https://doclerlabs.github.io/mobile-native-challenge")!
    var httpMethod: HttpMethod = .get
    var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
}
