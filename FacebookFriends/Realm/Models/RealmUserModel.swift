//
//  RealmUserModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 28.05.2023.
//

import Foundation
import RealmSwift

final class RealmAllUsersModel: Object {
    @Persisted var allUsersData: String?
    @Persisted var userName: String?
}
