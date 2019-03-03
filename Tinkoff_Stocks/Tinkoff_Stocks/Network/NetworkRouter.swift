//
//  NetworkRouter.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import Foundation

public protocol NetworkRouter: class {
    func getItem<Model: NetworkModel>(_ resource: APIType) -> Promise<Model>
    
    func getArray<Model: NetworkModel>(_ resource: APIType) -> Promise<[Model]>
}

public extension NetworkRouter {
    func getItem<Model: NetworkModel>(_ resource: APIType) -> Promise<Model> {
        print("\(self) didn't implement getItem<\(Model.self)>")
        
        return Promise<Model>()
    }
    
    func getArray<Model: NetworkModel>(_ resource: APIType) -> Promise<[Model]> {
        print("\(self) didn't implement getArray<[\(Model.self)]>")
        
        return Promise<[Model]>()
    }
}
