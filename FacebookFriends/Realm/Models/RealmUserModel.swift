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

//MARK: - UserList
//final class RealmAllUsersModel: Object {
//    @Persisted var allUsers: List<RealmUserModel?>
//    @Persisted var userName: String?
//}
//
////MARK: - MainUser
//final class RealmUserModel: Object {
//    @Persisted var name: RealmUserNameModel?
//    @Persisted var location: RealmUserLocationModel?
//    @Persisted var email: String?
//    @Persisted var dob: RealmDateOfBirthModel?
//    @Persisted var phone: String?
//    @Persisted var cell: String?
//    @Persisted var picture: RealmPictureModel?
//    @Persisted var nat: String?
//}
//
////MARK: - Name
//final class RealmUserNameModel: Object {
//    @Persisted var title: String?
//    @Persisted var first: String?
//    @Persisted var last: String?
//}
//
////MARK: - Location
//final class RealmUserLocationModel: Object {
//    @Persisted var street: RealmStreetModel?
//    @Persisted var city: String?
//    @Persisted var state: String?
//    @Persisted var country: String?
//    @Persisted var postcode: String?
//    @Persisted var coordinates: RealmCoordinateModel?
//}
//
////MARK: - Street
//final class RealmStreetModel: Object {
//    @Persisted var number: Int?
//    @Persisted var name: String?
//}
//
////MARK: - Coordinate
//final class RealmCoordinateModel: Object {
//    @Persisted var number: Int?
//    @Persisted var name: String?
//}
//
////MARK: - Picture
//final class RealmPictureModel: Object {
//    @Persisted var large: String?
//    @Persisted var medium: String?
//}
//
////MARK: - DateOfBirth
//final class RealmDateOfBirthModel: Object {
//    @Persisted var date: String?
//    @Persisted var age: Int?
//}
