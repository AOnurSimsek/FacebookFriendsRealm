//
//  UserProvider.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 25.05.2023.
//

import Foundation
import Alamofire

enum UserProvider {
    case getResults(ResultsRequestModel)
}

extension UserProvider: NetworkRequestable {
    
    var parameters: Parameters {
        switch self {
        case .getResults(let model):
            return model.asDictionary()
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
}


extension UserProvider: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try Service.url.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest = try encoding.encode(urlRequest,
                                         with: parameters)
        print(urlRequest.url)
        return urlRequest
    }
}

