//
//  UserAPI.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 25.05.2023.
//

import PromiseKit
import Alamofire


import Foundation
import Alamofire

protocol UsersAPIProtocol {
    func getResults(with model: ResultsRequestModel) -> Promise<ResultsResponseModel>
}

final class UsersAPI: UsersAPIProtocol {
    func getResults(with model: ResultsRequestModel) -> Promise<ResultsResponseModel> {
        let request = Alamofire.Session.default
            .request(UserProvider.getResults(model))

        return request
            .validate()
            .responseBaseDecodable(ResultsResponseModel.self)
    }
}
