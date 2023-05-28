//
//  UserCollectionViewCellContract.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import Foundation

enum UserCollectionViewCellButtonType {
    case map(CoordinateResponseModel?)
    case phone(String)
    case cellPhone(String)
    case email(String)
    case wikipedia(String)
}

protocol UserCollectionViewCellsDelegate: AnyObject {
    func didPressButton(buttonType: UserCollectionViewCellButtonType)
}
