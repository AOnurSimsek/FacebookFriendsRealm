//
//  LoginScreenViewModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 26.05.2023.
//

import UIKit

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

final class LoginViewModel {
    
    private let possibleUserNames: [String] = ["9nd54","v542w","17pcy0","gbf48","zdah4"]
    private var userName: String?
    private var password: String?
    private let router: LoginRouterProtocol
    let userNameChecker: Observable<Bool?> = Observable(nil)
    let loginError: Observable<LoginErrors?> = Observable(nil)
    
    init(router: LoginRouterProtocol) {
        self.router = router
    }
    
    func setPassword(text: String) {
        password = text
    }
    
    func checkUserName(userName: String) {
        let isValid = possibleUserNames.contains(userName)
        userNameChecker.value = isValid
        self.userName = isValid ? userName : nil
    }
    
    func didPressLoginButton() {
        if !(userNameChecker.value ?? false) {
            loginError.value = .invalidUserName
            return
        }
        
        if (password ?? "").isEmpty {
            loginError.value = .invalidPasswod
            return
        }
        
        router.route(to: .mainScreen(userName ?? ""),
                     sourceVC: nil)
    }
}
