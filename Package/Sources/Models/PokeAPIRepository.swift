//
//  PokeAPIRepository.swift
//
//
//  Created by Shota Fuchikami on 2021/12/11.
//

import Foundation
import Network

// MARK: Protocol

public protocol PokeAPIProtocol {
    func fetch<T>(from url: String, success: @escaping (T?) -> Void, failure: @escaping (Error) -> Void) where T : Decodable
}

// MARK: Implementation

public struct PokeAPIRepository: PokeAPIProtocol {
    public init() {}
    
    public func fetch<T>(from url: String, success: @escaping (T?) -> Void, failure: @escaping (Error) -> Void) where T : Decodable {
        APIClient.call(url, success: { (data: T?) in
            success(data)
        }, failure: { error in
            failure(error)
        })
    }
}
