//
//  DIC.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 12/14/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation
import RxSwift

typealias FactoryClosure = (DiContainer) -> AnyObject

protocol Containerizable {
    
}

protocol DiContainer {
    func resolve<T>(type: T.Type) -> T?
    func register<T>(type: T.Type, factory: @escaping FactoryClosure)
}

class Di: DiContainer {
    
    var services: Dictionary<String, FactoryClosure>
    
    init() {
        services = Dictionary()
    }
    
    func resolve<T>(type: T.Type) -> T? {
        return services["\(type)"]?(self) as? T
    }
    
    func register<T>(type: T.Type, factory: @escaping FactoryClosure) {
        services["\(type)"] = factory
    }
}
