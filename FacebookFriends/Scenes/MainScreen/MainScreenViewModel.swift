//
//  MainScreenViewModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 26.05.2023.
//

import UIKit

enum ProgressHudState {
    case shown
    case hidden
    case refreshHidden
}

enum GetUserDataStarterType {
    case refresh
    case normal
}

enum MainScreenState {
    case showProgressHUD
    case hideProgressHUD
    case hideRefreshHUD
    case dataReached
    case error(String)
}

final class MainScreenViewModel {
    
    private var userModel: [UserResponseModel]?
    private let userName: String
    private let networkService: UsersAPIProtocol
    private let router: MainScreenRouterProtocol
    private let realmManager: RealmManager
    
    let screenState: Observable<MainScreenState?> = Observable(nil)
    
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
        return userModel?[index]
    }
    
    func getUserModelCount() -> Int {
        return userModel?.count ?? 0
    }
    
    func getUserData(starter: GetUserDataStarterType) {
        switch starter {
        case .refresh:
            getUserDataFromService(starter: .refresh)
        case .normal:
            screenState.value = .showProgressHUD
            getRealmUserData()
        }
    }
    
    private func getRealmUserData() {
        if realmManager.hasRealmModel(userName: userName) {
            if let userData = realmManager.getUsersData(),
               !userData.isEmpty {
                userModel = userData
                screenState.value = .hideProgressHUD
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
                self.screenState.value = .error("An unkown error occured. Try again later.")
                return
            }
            
            self.userModel = response.results
            self.realmManager.addRealmModel(userName: self.userName,
                                            userModels: results,
                                            operationType: (starter == .refresh) ? .update : .write)
            self.screenState.value = .dataReached
        }.catch { error in
            print("Error at MainScreenViewModel getResults : " + error.localizedDescription)
            self.screenState.value = .error(error.localizedDescription)
        }.finally {
            switch starter {
            case .normal:
                self.screenState.value = .hideProgressHUD
            case .refresh:
                self.screenState.value = .hideRefreshHUD
            }
        }
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
