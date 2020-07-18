//
//  Networking.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 18.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import Combine

// Building networking layer using Functional programming,
// aka using pure functions and function composition.

//using Combine to achieve asynchronous networking function definition

typealias Networking = (URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error>

extension URLSession {
    func erasedDataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        dataTaskPublisher(for: request)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
