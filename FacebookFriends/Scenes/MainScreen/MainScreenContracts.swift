//
//  MainScreenContracts.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 1.06.2023.
//

import UIKit

// MARK: - ViewModel

protocol MainScreenViewModelProtocol {
    var screenState: Observable<MainScreenState?> { get set }
    func getUserModel(at index: Int) -> UserResponseModel?
    func getUserModelCount() -> Int
    func getUserData(starter: GetUserDataStarterType)
    func didSelectUser(at index: Int, source: UIViewController)
    func didPressedLogout()
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

// MARK: - Router

protocol MainScreenRouterProtocol: BaseRoutingProtocol,
                                   AnyObject {
    func route(to page: MainScreenRouterPageType,
               sourceVC: UIViewController?)
}

enum MainScreenRouterPageType {
    case loginScreen
    case detailScreen(UserResponseModel)
}
