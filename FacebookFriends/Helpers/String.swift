//
//  String.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import Foundation

extension String {
    func toDate() -> Date{
        let dateFormatter = DateFormatter()
        let formats: [String] = [
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd'T'HH:mm:ssZ",
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSSSXX",
            "yyyy-MM-dd'T'HH:mm:ss.SSSXXXZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX",
            "dd MMMM yyyy HH:mm",
            "dd MMMM yyyy",
            "dd/MM/yyyy"
            ]
        for format in formats {
            dateFormatter.dateFormat = format
            if let date = dateFormatter.date(from: self) {
                return date
            }
        }
        
        print("Invalid arguments ! Returning Current Date .")
        return Date()
    }
    
    func toOtherDate(with dateFormat: String = "dd.MM.yyyy") -> String {
        return toDate().toString(format: dateFormat)
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
}
