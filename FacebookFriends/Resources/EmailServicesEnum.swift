//
//  EmailServicesEnum.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 28.05.2023.
//

import Foundation

enum emailServices: CaseIterable {
    case appleMail
    case gmail
    case outlook
    case yahoo
    case spark
    
    var baseUrl: String {
        switch self {
        case .gmail:
            return "googlegmail://co?to="
        case .outlook:
            return "ms-outlook://compose?to="
        case .yahoo:
            return "ymail://mail/compose?to="
        case .spark:
            return "readdle-spark://compose?recipient="
        case .appleMail:
            return "mailto://"
        }
    }
}
