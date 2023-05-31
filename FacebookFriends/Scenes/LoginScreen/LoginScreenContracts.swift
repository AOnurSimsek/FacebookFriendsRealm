//
//  LoginScreenContracts.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 1.06.2023.
//

import UIKit

// MARK: - ViewModel

protocol LoginViewModelProtocol {
    var screenState: Observable<LoginScreenState?> { get set }
    func setPassword(text: String)
    func checkUserName(userName: String) -> Bool
    func didPressLoginButton()
}

enum LoginScreenState {
    case showProgressHUD
    case hideProgressHUD
    case userNameChecked(Bool)
    case showError(LoginErrors)
}

enum LoginErrors {
    case invalidUserName
    case invalidPasswod
    
    var description: String {
        switch self {
        case .invalidUserName:
            return "Invalid Username"
        case .invalidPasswod:
            return "Empty Password"
        }
    }
}

// MARK: - Router

protocol LoginRouterProtocol: BaseRoutingProtocol,
                              AnyObject {
    func route(to page: LoginRouterPageType,
               sourceVC: UIViewController?)
}

enum LoginRouterPageType {
    case mainScreen(String)
}
