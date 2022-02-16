//
//  APIClient.swift
//  
//
//  Created by Shota Fuchikami on 2022/02/16.
//

import Alamofire
import Foundation

public struct APIClient {
    public static func call<T>(_ url: String, success: @escaping (T?) -> Void, failure: @escaping (Error) -> Void) where T : Decodable {
        request(url).responseDecodable { (response: AFDataResponse<T?>) in
            switch response.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    private static func request(_ url: String) -> DataRequest {
        return AF.request(url).validate(statusCode: 200..<400).validate(contentType: ["application/json"])
    }
}
