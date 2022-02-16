//
//  APIRequestConsts.swift
//  
//
//  Created by Shota Fuchikami on 2022/02/16.
//

import Foundation

// MARK: - APIRequestConsts
enum APIRequestConsts {
    case base
    case limit
    
    var path: [String] {
        switch self {
        case .base, .limit:
            return ["api", "v2", "pokemon"]
        }
    }
    
    static var url = "https://pokeapi.co"
}

// MARK: - APIRequestError
enum APIRequestError: Error {
    case InvalidURLError
}
