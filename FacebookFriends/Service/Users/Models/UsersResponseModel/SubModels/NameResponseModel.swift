//
//  NameResponseModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 25.05.2023.
//

import Foundation

struct NameResponseModel: Codable {
    let title: String?
    let first: String?
    let last: String?
    
    func getUSerFullName() -> String {
        return (title ?? "") + "." + " " + (first ?? "") + " " + (last ?? "")
    }
}
