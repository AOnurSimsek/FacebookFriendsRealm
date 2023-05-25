//
//  PictureResponseModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 25.05.2023.
//

import Foundation

struct PictureResponseModel: Decodable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}
