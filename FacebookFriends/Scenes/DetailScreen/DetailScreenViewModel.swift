//
//  DetailScreenViewModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit

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
    case dateofBirth(RegisteredResponseModel?)
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

final class DetailScreenViewModel {
    
    private let userModel: UserResponseModel
    private let router: DetailScreenRouterProtocol
    private var detailSections: [DetailScreenCollectionViewCellType] = []
    let appState: Observable<DetailScreenPageState?> = Observable(nil)
    
    init(userModel: UserResponseModel,
         router: DetailScreenRouterProtocol) {
        self.userModel = userModel
        self.router = router
    }
    
    private func setSections(with userModel: UserResponseModel) {
        if userModel.phone != nil || userModel.cell != nil || userModel.email != nil {
            detailSections.append(.contact(.init(phone: userModel.phone,
                                                 cellPhone: userModel.cell,
                                                 email: userModel.email)))
        }
        
        if let dob = userModel.dob {
            detailSections.append(.dateofBirth(dob))
        }
        
        if let location = userModel.location {
            detailSections.append(.location(location))
        }
        
        if let nationality = userModel.nat {
            detailSections.append(.nationality(nationality))
        }
        
    }
    
    func loadUserData() {
        setSections(with: userModel)
        appState.value = detailSections.isEmpty ? .error(.load) : .reload
    }
    
    func getSectionCount() -> Int {
        return detailSections.count
    }
    
    func getSection(for section: Int) -> DetailScreenCollectionViewCellType {
        return detailSections[section]
    }
    
    func getUserHeaderModel() -> UserHeaderModel {
        let model: UserHeaderModel = .init(name: userModel.name?.getUSerFullName() ?? "",
                                           urlString: userModel.picture?.large ?? "")
        return model
    }
    
    func didPressedButton(type: UserCollectionViewCellButtonType) {
        switch type {
        case .map(let coordinateResponseModel):
            guard let stringLatitude = coordinateResponseModel?.latitude,
                  let stringLongitude = coordinateResponseModel?.longitude,
                  let doubleLatitude = Double(stringLatitude),
                  let doubleLongitude = Double(stringLongitude)
            else { return }
            
            try? router.route(to: .map(doubleLatitude, doubleLongitude))
            
        case .phone(let number):
            do {
                try router.route(to: .phone(number.onlyDigits()))
            } catch {
                appState.value = .error(.cantOpenPhone)
            }
            
        case .cellPhone(let number):
            do {
                try router.route(to: .message(number.onlyDigits()))
            } catch {
                appState.value = .error(.cantOpenSMS)
            }
            
        case .email(let email):
            do {
               try router.route(to: .email(email))
            } catch {
                appState.value = .error(.cantOpenMail)
            }
            
        case .wikipedia(let countryName):
            let url = "https://en.wikipedia.org/wiki/" + countryName
            guard let _url = URL(string: url)
            else {
                appState.value = .error(.cantOpenWikipedia)
                return
            }
            
            try? router.route(to: .wikipedia(_url))
        }
    }
    
}
