//
//  UserResponseModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 25.05.2023.
//

import Foundation

struct UserResponseModel: Codable {
    let name: NameResponseModel?
    let location: LocationResponseModel?
    let email: String?
    let dob: DateOfBirthResponseModel?
    let phone: String?
    let cell: String?
    let picture: PictureResponseModel?
    let nat: String?
}
