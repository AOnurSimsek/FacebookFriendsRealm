//
//  MainScreenViewModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 26.05.2023.
//

import UIKit

enum MainScreenErrors {
    case networkError(String)
    case unknown(String)
}

enum ProgressHudState {
    case shown
    case hidden
    case refreshHidden
}

enum GetUserDataStarterType {
    case refresh
    case normal
}

final class MainScreenViewModel {
    
    let userModel: Observable<[UserResponseModel]?> = Observable(nil)
    let mainScreenError: Observable<MainScreenErrors?> = Observable(nil)
    let progressHudState: Observable<ProgressHudState?> = Observable(nil)
    private let userName: String
    private let networkService: UsersAPIProtocol
    private let router: MainScreenRouterProtocol
    private let realmManager: RealmManager
    
    init(userName: String,
         networkService: UsersAPIProtocol,
         router: MainScreenRouterProtocol,
         realmManager: RealmManager) {
        self.userName = userName
        self.networkService = networkService
        self.router = router
        self.realmManager = realmManager
    }
    
    func getUserModel(at index: Int) -> UserResponseModel? {
        return userModel.value?[index]
    }
    
    func getUserModelCount() -> Int {
        return userModel.value?.count ?? 0
    }
    
    func getUserData(starter: GetUserDataStarterType) {
        switch starter {
        case .refresh:
            getUserDataFromService(starter: .refresh)
        case .normal:
            progressHudState.value = .shown
            getRealmUserData()
        }
    }
    
    private func getRealmUserData() {
        if realmManager.hasRealmModel(userName: userName) {
            if let userData = realmManager.getUsersData(),
               !userData.isEmpty {
                userModel.value = userData
                progressHudState.value = .hidden
            } else {
                getUserDataFromService(starter: .normal)
            }
        } else {
            getUserDataFromService(starter: .normal)
        }
    }
    
    private func getUserDataFromService(starter: GetUserDataStarterType) {
        networkService.getResults(with: .init(results: 20)).done { response in
            guard let results = response.results,
                  !results.isEmpty
            else {
                self.mainScreenError.value = .networkError("An unkown error occured. Try again later.")
                return
            }
            
            self.userModel.value = response.results
            self.realmManager.addRealmModel(userName: self.userName,
                                            userModels: results,
                                            operationType: (starter == .refresh) ? .update : .write)
        }.catch { error in
            print("Error at MainScreenViewModel getResults")
            self.mainScreenError.value = .networkError(error.localizedDescription)
        }.finally {
            switch starter {
            case .normal:
                self.progressHudState.value = .hidden
            case .refresh:
                self.progressHudState.value = .refreshHidden
            }
        }
    }
    
    private func saveToRealm(userData: [UserResponseModel]) {
        
    }
    
    func didSelectUser(at index: Int,
                       source: UIViewController) {
        guard let userData = getUserModel(at: index)
        else { return }
        
        router.route(to: .detailScreen(userData),
                     sourceVC: source)
    }
    
    func didPressedLogout() {
        router.route(to: .loginScreen,
                     sourceVC: nil)
    }
}
