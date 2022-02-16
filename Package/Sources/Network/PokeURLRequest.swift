//
//  PokeURLRequest.swift
//  
//
//  Created by Shota Fuchikami on 2022/02/16.
//

import Alamofire
import Foundation

// MARK: - PokeURLRequestProtocol
public protocol PokeURLRequestProtocol {
    var urlStr: String { get }
    var pathList: [String] { get }
    var parameters: [String: Any]? { get }
}

extension PokeURLRequestProtocol {
    public func urlRequest() throws -> URLRequest {
        guard var url = URL(string: urlStr) else {
            throw APIRequestError.InvalidURLError
        }
        for path in pathList {
            url = url.appendingPathComponent(path)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.timeoutInterval = TimeInterval(10)
        if let paramters = parameters {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: paramters)
        }
        return urlRequest
    }
}

// MARK: - PokeBaseURLRequest
public struct PokeBaseURLRequest: PokeURLRequestProtocol {
    
    // MARK: Field Property
    
    public var urlStr: String {
        return APIRequestConsts.url
    }
    public var pathList: [String] {
        return APIRequestConsts.base.path
    }
    public var parameters: [String: Any]? {
        return nil
    }
    
    // MARK: Initializer
    
    public init() {}
}

// MARK: - PokeLimitURLRequest
public struct PokeLimitURLRequest: PokeURLRequestProtocol {
    
    // MARK: Field Property
    
    public var urlStr: String {
        return APIRequestConsts.url
    }
    public var pathList: [String] {
        return APIRequestConsts.base.path
    }
    public var parameters: [String: Any]? {
        return ["limit": paramValue]
    }
    var paramValue: String
    
    // MARK: Initializer
    
    public init(paramValue: String) {
        self.paramValue = paramValue
    }
}
