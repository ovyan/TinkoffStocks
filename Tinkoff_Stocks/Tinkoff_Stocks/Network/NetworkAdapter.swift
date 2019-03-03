//
//  NetworkAdapter.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import Foundation

public protocol NetworkAdapter: class {
    
    func adapt(_ resource: APIResource) -> Endpoint?
    
    func adapt(_ path: String, query: NetworkQuery) -> Endpoint?
}

public final class ResourceAdapter: NetworkAdapter {
    
    public func adapt(_ resource: APIResource) -> Endpoint? {
        guard var components = URLComponents(string: resource.url) else {
            print("Can't process [\(resource.url)], query: \(resource.query ?? "none")")
            return nil
        }
        components.query = resource.query
        guard let url = components.url else {
            print("Can't construct url from \(components)")
            return nil
        }
        
        return Endpoint(url: url, headers: nil)
    }
    
    public func adapt(_ path: String, query: NetworkQuery) -> Endpoint? {
        let resource = APIResource(url: path, query: query.stringValue)
        
        return adapt(resource)
    }
    
    public func adapt(_ path: String) -> Endpoint? {
        let resource = APIResource(url: path, query: nil)
        
        return adapt(resource)
    }
}
