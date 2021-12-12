//
//  PokeApiRepository.swift
//
//
//  Created by Shota Fuchikami on 2021/12/11.
//

import Alamofire
import Foundation

// MARK: Protocol

public protocol PokeApiRepositoryProtocol {
    func fetch<T: Decodable>(from url: String, completion: @escaping (T?) -> Void)
    func download(from url: String, completion: @escaping (Data?) -> Void)
}

// MARK: Implementation

public struct PokeApiRepository: PokeApiRepositoryProtocol {
    public init() {}

    public func fetch<T: Decodable>(from url: String, completion: @escaping (T?) -> Void) {
        AF.request(url).responseJSON { response in
            guard let data = response.data else {
                print("\(#function) Some error caused. data is nil.")
                completion(nil)
                return
            }
            print(data)
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                print("\(#function) JSON Decode error caused.")
                completion(nil)
                return
            }
            print("\(#function) Success.")
            completion(result)
        }
    }

    public func download(from url: String, completion: @escaping (Data?) -> Void) {
        AF.request(url).response { response in
            guard let data = response.data else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
}
