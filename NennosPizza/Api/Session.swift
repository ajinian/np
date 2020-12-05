//
//  Session.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/4/20.
//

import Foundation

protocol SessionProtocol {
    var apiSession: URLSession { set get }
}

class Session: SessionProtocol {
    
    var apiSession: URLSession
    
    init() {
        let config: URLSessionConfiguration = .default
        config.httpAdditionalHeaders = [
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        ]
        apiSession = URLSession(configuration: config)
    }
}
