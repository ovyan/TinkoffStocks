//
//  RequestSender.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import Foundation

public final class RequestSender {

    public let session: URLSession

    public let queue: DispatchQueue

    public func send(_ request: URLRequest) -> DataPromise {
        let response = DataPromise()
        let task = makeTask(for: .urlRequest(request), response)
        task.resume()

        return response
    }

    public func send(_ endpoint: URL) -> Promise<Data> {
        let response = DataPromise()
        let task = makeTask(for: .url(endpoint), response)
        task.resume()

        return response
    }

    public init(session: URLSession, queue: DispatchQueue) {
        self.session = session
        self.queue = queue
    }

    public convenience init(session: URLSession) {
        let queue = DispatchQueue(label: "core.net", qos: .default, attributes: .concurrent)
        self.init(session: session, queue: queue)
    }

    public convenience init(queue: DispatchQueue) {
        let session = URLSession.shared
        self.init(session: session, queue: queue)
    }

    public convenience init() {
        let queue = DispatchQueue(label: "core.net", qos: .default, attributes: .concurrent)
        let session = URLSession.shared
        self.init(session: session, queue: queue)
    }

    private func makeTask(for request: RequestConvertible, _ completion: DataPromise) -> URLSessionDataTask {
        switch request {
        case .urlRequest(let request):
            return process(request, completion)

        case .url(let url):
            return process(url, completion)

        case .string(let url):
            return process(url, completion)
        }
    }

    private func process(_ request: URLRequest, _ completion: DataPromise) -> URLSessionDataTask {
        return session.dataTask(with: request) { data, _, err in
            self.reject(with: err, promise: completion)

            completion.fulfill(optional: data)
        }
    }

    private func process(_ url: URL, _ completion: DataPromise) -> URLSessionDataTask {
        return session.dataTask(with: url) { data, _, err in
            self.reject(with: err, promise: completion)

            completion.fulfill(optional: data)
        }
    }

    private func process(_ url: String, _ completion: DataPromise) -> URLSessionDataTask {
        let url = URL(string: url)
        assert(url != nil)

        return session.dataTask(with: url!) { data, _, err in
            self.reject(with: err, promise: completion)

            completion.fulfill(optional: data)
        }
    }

    private func reject(with error: Error?, promise: DataPromise) {
        if let error = error {
            promise.reject(error)
        }
    }
}
