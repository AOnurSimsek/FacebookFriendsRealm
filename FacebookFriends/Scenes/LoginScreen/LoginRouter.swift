//
//  LoginRouter.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit

enum LoginRouterPageType {
    case mainScreen(String)
}

protocol LoginRouterProtocol: BaseRoutingProtocol,
                              AnyObject {
    func route(to page: LoginRouterPageType,
               sourceVC: UIViewController?)
}

final class loginRouter: LoginRouterProtocol {
    func route(to page: LoginRouterPageType,
               sourceVC: UIViewController?) {
        switch page {
        case .mainScreen(let userName):
            let destinationVC = ScreenBuilder().build(type: .MainScreen(userName))
            showDestinationasNewRootWindows(destination: destinationVC,
                                            transistionType: .transitionCrossDissolve)
        }
    }
}
