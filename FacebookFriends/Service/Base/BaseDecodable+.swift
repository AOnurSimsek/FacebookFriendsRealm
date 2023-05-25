//
//  BaseDecodable.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 25.05.2023.
//

import Foundation
import Alamofire
import PromiseKit

extension Alamofire.DataRequest{
    public func responseBaseDecodable<T: Decodable>(_ type: T.Type, queue: DispatchQueue? = nil, decoder: JSONDecoder = JSONDecoder()) -> Promise<T> {
        return Promise { seal in
            responseData(queue: queue ?? .main) { response in
                switch response.result {
                case .success(let value):
                    do {
                        seal.fulfill(try decoder.decode(type, from: value))
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}
