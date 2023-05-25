//
//  InfoResponseModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 25.05.2023.
//

import Foundation

struct InfoResponseModel: Decodable {
    let seed: String?
    let results: Int?
    let page: Int?
    let version: String?
}
