//
//  PokeAPIRepository.swift
//
//
//  Created by Shota Fuchikami on 2021/12/11.
//

import Foundation
import Network

// MARK: - PokeAPIProtocol
public protocol PokeAPIProtocol {
    func fetch<T>(from url: PokeURLRequestProtocol, success: @escaping (T?) -> Void, failure: @escaping (Error) -> Void) where T : Decodable
}

// MARK: - PokeAPIRepository
public struct PokeAPIRepository: PokeAPIProtocol {
    
    // MARK: Initializer
    
    public init() {}
    
    // MARK: Methods
    
    public func fetch<T>(from url: PokeURLRequestProtocol, success: @escaping (T?) -> Void, failure: @escaping (Error) -> Void) where T : Decodable {
        do {
            let urlRequest = try url.urlRequest()
            APIClient.call(urlRequest, success: { (data: T?) in
                success(data)
            }, failure: { error in
                failure(error)
            })
        } catch let error {
            failure(error)
        }
    }
}
