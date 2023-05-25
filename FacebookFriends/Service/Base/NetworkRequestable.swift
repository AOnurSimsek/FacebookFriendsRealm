//
//  NetworkRequestable.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 25.05.2023.
//

import Alamofire

protocol NetworkRequestable {
    var parameters: Parameters { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}
