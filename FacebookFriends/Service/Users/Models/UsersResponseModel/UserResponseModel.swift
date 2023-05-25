//
//  UserResponseModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 25.05.2023.
//

import Foundation

struct UserResponseModel: Decodable {
    let gender: String?
    let name: NameResponseModel?
    let location: LocationResponseModel?
    let email: String?
    let login: LoginResponseModel?
    let registered: RegisteredResponseModel?
    let phone: String?
    let cell: String?
    let ID: IDResponseModel?
    let picture: PictureResponseModel?
    let nat: String?
}
