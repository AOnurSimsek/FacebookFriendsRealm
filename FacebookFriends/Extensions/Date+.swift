//
//  Date+.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import Foundation

extension Date {
    func toString(format dateFormat: String = "dd.MM.yyyy") -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let dateString: String = formatter.string(from: self)
        return dateString
    }
}
