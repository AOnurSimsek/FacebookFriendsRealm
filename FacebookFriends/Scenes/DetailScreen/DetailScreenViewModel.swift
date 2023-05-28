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

// MARK: - CollectionViewHeightCalculator
extension DetailScreenViewModel: TextHeightCalculatorProtocol {
    func getCellHeight(for section: Int) -> CGSize {
        let currentSection = getSection(for: section)
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        let baseVerticalSpacing: CGFloat = 15 + 15
        let baseHorizontalSpacing: CGFloat = 20 + 20
        let innerStackVerticalSpacing: CGFloat = 10
        let innterStackHorizontalSpacing: CGFloat = 10
        let buttonWidthHeight: CGFloat = 30
        let titleLabelWidth: CGFloat = 115
        
        switch currentSection {
        case .contact(let userContactModel):
            let baseHeight: CGFloat = baseVerticalSpacing + 30 + 30 + 30 + (innterStackHorizontalSpacing * 2)
            
            guard let model = userContactModel
            else {
                return .init(width: screenWidth, height: baseHeight)
            }
            
            let phoneLabelText = model.phone ?? "-"
            let cellPhoneLabelText = model.cellPhone ?? "-"
            let emailLabelText = model.email ?? "-"
            
            let remainingWidth: CGFloat = screenWidth - baseHorizontalSpacing - titleLabelWidth - buttonWidthHeight - (innterStackHorizontalSpacing*2)

            let topLabelHeight: CGFloat = calculateTextRequiredHeight(text: phoneLabelText,
                                                                      labelWidth: remainingWidth,
                                                                      font: .systemFont(ofSize: 17))
            let middleLabelHeight: CGFloat = calculateTextRequiredHeight(text: cellPhoneLabelText,
                                                                         labelWidth: remainingWidth,
                                                                         font: .systemFont(ofSize: 17))
            let bottomLabelHeight: CGFloat = calculateTextRequiredHeight(text: emailLabelText,
                                                                         labelWidth: remainingWidth - 100,
                                                                         font: .systemFont(ofSize: 17))
            
            let titleHeights: CGFloat = bottomLabelHeight + middleLabelHeight + topLabelHeight
            let innerVerticalStackHeights: CGFloat = innerStackVerticalSpacing * 2
            let totalHeight: CGFloat = max(titleHeights, 90) + innerVerticalStackHeights + baseVerticalSpacing
            
            return .init(width: screenWidth, height: max(totalHeight, baseHeight))
            
        case .dateofBirth:
            let baseHeight: CGFloat = 21 + 21 + 10 + baseVerticalSpacing
            return .init(width: screenWidth, height: baseHeight)
            
        case .location(let locationModel):
            let baseHeight: CGFloat = baseVerticalSpacing + 21 + 21 + 21 + (innterStackHorizontalSpacing * 2)
            
            guard let model = locationModel
            else {
                return .init(width: screenWidth, height: baseHeight)
            }
            
            let topLabel = String(model.street?.number ?? 0) + " " + (model.street?.name ?? "-")
            let middleLabel = (model.state ?? " ") + " - " + (model.city ?? " ")
            let bottomLabel = (model.country ?? "-")
            
            let remainingWidth: CGFloat = screenWidth - baseHorizontalSpacing - titleLabelWidth - buttonWidthHeight - (innterStackHorizontalSpacing*2)
            let topLabelHeight: CGFloat = calculateTextRequiredHeight(text: topLabel,
                                                                      labelWidth: remainingWidth,
                                                                      font: .systemFont(ofSize: 17))
            let middleLabelHeight: CGFloat = calculateTextRequiredHeight(text: middleLabel,
                                                                         labelWidth: remainingWidth,
                                                                         font: .systemFont(ofSize: 17))
            let bottomLabelHeight: CGFloat = calculateTextRequiredHeight(text: bottomLabel,
                                                                         labelWidth: remainingWidth,
                                                                         font: .systemFont(ofSize: 17))
            
            let titleHeights: CGFloat = bottomLabelHeight + middleLabelHeight + topLabelHeight
            let innerVerticalStackHeights: CGFloat = innerStackVerticalSpacing * 2
            let totalHeight: CGFloat = titleHeights + innerVerticalStackHeights + baseVerticalSpacing
            
            return .init(width: screenWidth, height: max(totalHeight, baseHeight))
            
        case .nationality(let country):
            let baseHeight: CGFloat = 60
            
            guard let _country = country,
                  let countryModel: Iso3166_1a2 = .init(rawValue: _country)
            else {
                return .init(width: screenWidth, height: baseHeight)
            }
            
            let countryText = countryModel.country + " "
            let horizontalSpacing: CGFloat = 3 * innterStackHorizontalSpacing
            let emojiSize: CGFloat = 100
            let remainingWidth: CGFloat = screenWidth - titleLabelWidth - horizontalSpacing - buttonWidthHeight - baseHorizontalSpacing - emojiSize
            let textHeight: CGFloat = calculateTextRequiredHeight(text: countryText,
                                                                  labelWidth: remainingWidth,
                                                                  font: .systemFont(ofSize: 17))
            return .init(width: screenWidth, height: max(baseHeight, textHeight))
            
        }
        
    }
    
}
