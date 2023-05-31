//
//  MainScreenRouter.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 26.05.2023.
//

import UIKit

final class MainScreenRouter: MainScreenRouterProtocol {
    func route(to page: MainScreenRouterPageType,
               sourceVC: UIViewController?) {
        switch page {
        case .loginScreen:
            let destinationVC = ScreenBuilder().build(type: .LoginScreen)
            showDestinationasNewRootWindows(destination: destinationVC,
                                            transistionType: .transitionFlipFromLeft)
        case .detailScreen(let userModel):
            guard let _sourceVC = sourceVC
            else { return }
            
            let destinationVC = ScreenBuilder().build(type: .DetailScreen(userModel))
            navigateToDestination(source: _sourceVC,
                                  destination: destinationVC)
        }
    }
    
}
