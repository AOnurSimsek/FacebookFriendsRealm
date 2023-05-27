//
//  BaseRoutingProtocol.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit

protocol BaseRoutingProtocol { }

extension BaseRoutingProtocol {
    func showDestinationasNewRootWindows(destination: UIViewController,
                                         transistionType: UIView.AnimationOptions) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appDelegate.window
        else { return }
        
        window.rootViewController = UINavigationController(rootViewController: destination)
        UIView.transition(with: window,
                          duration: 0.5,
                          options: transistionType,
                          animations: {})
    }
    
    func navigateToDestination(source: UIViewController,
                               destination: UIViewController) {
        source.show(destination, sender: nil)
    }
    
    func presentDestination(source: UIViewController,
                            presentationType: UIModalPresentationStyle,
                            destination: UIViewController) {
        destination.modalPresentationStyle = presentationType
        source.present(destination, animated: false)
    }
    
    func poptoRoute(source: UIViewController) {
        source.navigationController?.popToRootViewController(animated: false)
    }
}
