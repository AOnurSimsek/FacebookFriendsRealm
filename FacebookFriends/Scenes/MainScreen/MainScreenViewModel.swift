//
//  MainScreenViewModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 26.05.2023.
//

import UIKit

enum MainScreenErrors {
    case networkError(String)
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
    
    init(userName: String,
         networkService: UsersAPIProtocol,
         router: MainScreenRouterProtocol) {
        self.userName = userName
        self.networkService = networkService
        self.router = router
    }
    
    func getUserModel(at index: Int) -> UserResponseModel? {
        return userModel.value?[index]
    }
    
    func getUserModelCount() -> Int {
        return userModel.value?.count ?? 0
    }
    
    func getUserData(starter: GetUserDataStarterType) {
        progressHudState.value = (starter == .normal) ? .shown : nil
        networkService.getResults(with: .init(results: 20)).done { response in
            self.userModel.value = response.results
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
    
    func didSelectUser(at index: Int,
                       source: UIViewController) {
        guard let userData = getUserModel(at: index)
        else { return }
        
        router.route(to: .detailScreen(userData),
                     sourceVC: source)
    }
}
