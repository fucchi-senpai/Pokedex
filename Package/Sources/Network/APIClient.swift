//
//  APIClient.swift
//  
//
//  Created by Shota Fuchikami on 2022/02/16.
//

import Alamofire
import Foundation

public struct APIClient {
    
    // MARK: Methods
    
    public static func call<T>(_ urlRequest: URLRequest, success: @escaping (T?) -> Void, failure: @escaping (
        Error) -> Void) where T : Decodable {
        request(urlRequest).responseDecodable { (response: AFDataResponse<T?>) in
            switch response.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    // MARK: Other Private Methods
    
    private static func request(_ urlRequest: URLRequest) -> DataRequest {
        return AF.request(urlRequest).validate(statusCode: 200..<400).validate(contentType: ["application/json"])
    }
}
