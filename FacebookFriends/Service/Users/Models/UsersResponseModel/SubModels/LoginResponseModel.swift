//
//  LoginResponseModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 25.05.2023.
//

import Foundation

struct LoginResponseModel: Decodable {
    let uuid: String?
    let username: String?
    let password: String?
    let salt: String?
    let md5: String?
    let sha1: String?
    let sha256: String?
}
