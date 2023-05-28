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
    case DetailScreen(UserResponseModel)
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
            let networkService: UsersAPIProtocol = UsersAPI()
            let realmManager: RealmManager = .init()
            let router: MainScreenRouter = .init()
            let viewModel: MainScreenViewModel = .init(userName: userName,
                                                       networkService: networkService,
                                                       router: router,
                                                       realmManager: realmManager)
            let destinationVC: MainScreenViewController = .init(viewModel: viewModel)
            return destinationVC
            
        case .DetailScreen(let userModel):
            let router: DetailScreenRouter = .init()
            let viewModel: DetailScreenViewModel = .init(userModel: userModel,
                                                         router: router)
            let destinationVC: DetailScreenViewController = .init(viewModel: viewModel)
            return destinationVC
        }
        
    }
    
}
