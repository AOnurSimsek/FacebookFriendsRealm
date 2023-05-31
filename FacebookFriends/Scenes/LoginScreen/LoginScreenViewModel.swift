//
//  LoginScreenViewModel.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 26.05.2023.
//

import UIKit

final class LoginViewModel: LoginViewModelProtocol {
    private let possibleUserNames: [String] = ["9nd54","v542w","17pcy0","gbf48","zdah4"]
    private var userName: String?
    private var password: String?
    private let router: LoginRouterProtocol
    var screenState: Observable<LoginScreenState?> = Observable(nil)
    
    init(router: LoginRouterProtocol) {
        self.router = router
    }
    
    func setPassword(text: String) {
        password = text
    }
    
    func checkUserName(userName: String) -> Bool {
        let isValid = possibleUserNames.contains(userName)
        self.userName = isValid ? userName : nil
        screenState.value = .userNameChecked(isValid)
        return isValid
    }
    
    func didPressLoginButton() {
        if !(checkUserName(userName: userName ?? "") ) {
            screenState.value = .showError(.invalidUserName)
            screenState.value = .hideProgressHUD
            return
        }
        
        if (password ?? "").isEmpty {
            screenState.value = .showError(.invalidPasswod)
            screenState.value = .hideProgressHUD
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.screenState.value = .hideProgressHUD
            self.router.route(to: .mainScreen(self.userName ?? ""),
                              sourceVC: nil)
        }
    }
}
