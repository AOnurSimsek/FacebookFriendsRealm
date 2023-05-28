//
//  ResultsResponseModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 25.05.2023.
//

import Foundation

struct ResultsResponseModel: Decodable {
    let results: [UserResponseModel]?
}
