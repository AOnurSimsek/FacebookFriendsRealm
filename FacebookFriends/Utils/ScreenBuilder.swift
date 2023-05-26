//
//  DestinationBuilder.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit

enum DestinationBuilderPageType {
    case LoginScreen
    case MainScreen(String)
}

final class ScreenBuilder {
    func build(type: DestinationBuilderPageType) -> UIViewController {
        switch type {
        case .LoginScreen:
            let router: LoginRouterProtocol = loginRouter()
            let viewModel: LoginViewModel = .init(router: router)
            let controller: LoginScreenViewController = .init(viewModel: viewModel)
            return controller
        case .MainScreen(let userName):
            let viewModel: MainScreenViewModel = .init(userName: userName)
            let destinationVC: MainScreenViewController = .init(viewModel: viewModel)
            return destinationVC
        }
    }
}
