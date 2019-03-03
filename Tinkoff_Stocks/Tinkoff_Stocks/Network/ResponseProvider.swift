//
//  ResponseProvider.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import Foundation

public protocol IResponseProvider: class {
    
    func getItem<Model: Unmarshaling>(_ endpoint: Endpoint) -> Promise<Model>
    
    func getArray<Model: Unmarshaling>(_ endpoint: Endpoint) -> Promise<[Model]>
}

public final class ResponseProvider: IResponseProvider {
    
    private let sender: RequestSender
    
    public func getItem<Model: Unmarshaling>(_ endpoint: Endpoint) -> Promise<Model> {
        return getResponse(endpoint)
            .then(JSONParser.JSONObjectWithData)
            .then(Model.init(object:))
    }
    
    public func getArray<Model: Unmarshaling>(_ endpoint: Endpoint) -> Promise<[Model]> {
        return getResponse(endpoint)
            .then(JSONParser.JSONArrayWithData)
            .then { $0.map { try? Model(object: $0) } }
            .then(Promise.fromOptional)
    }
    
    private func getResponse(_ endpoint: Endpoint) -> DataPromise {
        let request = buildRequest(using: endpoint)
        
        return sender.send(request)
    }
    
    private func buildRequest(using endpoint: Endpoint) -> URLRequest {
        var request = URLRequest(url: endpoint.url)
        request.allHTTPHeaderFields = endpoint.headers
        request.httpMethod = HTTPMethod.GET.rawValue
        
        return request
    }
    
    public init(sender: RequestSender) {
        self.sender = sender
    }
    
    public convenience init() {
        self.init(sender: RequestSender())
    }
}
