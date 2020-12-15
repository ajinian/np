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

protocol DiContainer {
    func resolve<Service>(type: Service.Type) -> Service?
    func register<Service>(type: Service.Type, factory: @escaping FactoryClosure)
}

class Di: DiContainer {
    
    var services: Dictionary<String, FactoryClosure>
    
    init() {
        services = Dictionary()
    }
    
    func resolve<Service>(type: Service.Type) -> Service? {
        return services["\(type)"]?(self) as? Service
    }
    
    func register<Service>(type: Service.Type, factory: @escaping FactoryClosure) {
        services["\(type)"] = factory
    }
}
