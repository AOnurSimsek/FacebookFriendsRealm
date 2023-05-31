//
//  DetailScreenContracts.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 1.06.2023.
//

import Foundation

// MARK: - ViewModel

protocol DetailScreenViewModelProtocol: TextHeightCalculatorProtocol {
    var appState: Observable<DetailScreenPageState?> { get set }
    func loadUserData()
    func getSectionCount() -> Int
    func getSection(for section: Int) -> DetailScreenCollectionViewCellType
    func getUserHeaderModel() -> UserHeaderModel
    func didPressedButton(type: UserCollectionViewCellButtonType)
    func getCellHeight(for section: Int) -> CGSize
}

enum DetailScreenPageState {
    case reload
    case error(DetailScreenErrorTypes)
}

enum DetailScreenErrorTypes: Error {
    case load
    case cantOpenPhone
    case cantOpenSMS
    case cantOpenMail
    case cantOpenWikipedia
    
    var description: String {
        switch self {
        case .load:
            return "Data could not loaded. Try again later."
        case .cantOpenPhone:
            return "Phone could not opened."
        case .cantOpenSMS:
            return "Sms app could not opened."
        case .cantOpenMail:
            return "Mail app could not opened"
        case .cantOpenWikipedia:
            return "Wikipedia page could not opened."
        }
    }
}

enum DetailScreenCollectionViewCellType: Equatable {
    case contact(UserContactModel?)
    case dateofBirth(DateOfBirthResponseModel?)
    case location(LocationResponseModel?)
    case nationality(String?)
    
    static func == (lhs: DetailScreenCollectionViewCellType, rhs: DetailScreenCollectionViewCellType) -> Bool {
        switch(lhs, rhs) {
        case (.contact, .contact):
            return true
        case (.dateofBirth, .dateofBirth):
            return true
        case (.location, .location):
            return true
        case (.nationality, .nationality):
            return true
        default:
            return false
        }
    }
    
}

// MARK: - Router

protocol DetailScreenRouterProtocol: BaseRoutingProtocol,
                                     AnyObject {
    func route(to page: DetailScreenRouterPageType) throws
}

enum DetailScreenRouterPageType {
    case phone(String)
    case message(String)
    case email(String)
    case map(Double,Double)
    case wikipedia(URL)
}
