//
//  UIViewController+.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 26.05.2023.
//

import UIKit

enum NavigationBarType {
    case color
    case clear
    case hidden
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay"
                                      , style: .default,
                                      handler: nil))
        self.present(alert, animated: false)
    }
    
    func setStatusbarColor(color: UIColor) {
        UIApplication.shared.statusBarView?.backgroundColor = color
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func setNavigationBarStyle(type: NavigationBarType,
                               color: UIColor,
                               isBarShadowOpened: Bool,
                               title: String = ""){
        switch type {
        case .color:
            setStatusbarColor(color: color)
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                        for:.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.layoutIfNeeded()
            self.navigationController?.navigationBar.barTintColor = color
            self.navigationController?.navigationBar.backgroundColor = color
            self.navigationController?.navigationBar.isTranslucent = false
            setNavigationBarShadow(color: isBarShadowOpened ? Colors.navigationBarLowBlackShadow : .clear,
                                   opacity: 1,
                                   radius: 8,
                                   offset: CGSize(width: 0, height: 10))
            setNavigationBarTitle(title: title)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21,
                                                                                                                           weight: .heavy),
                                                                            NSAttributedString.Key.foregroundColor: UIColor.white]
        case .clear:
            setStatusbarColor(color: .clear)
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                        for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.backgroundColor = .clear
            setNavigationBarShadow(color: .clear)
            setNavigationBarTitle(title: title)
        case .hidden:
            setStatusbarColor(color: .clear)
            self.navigationController?.setNavigationBarHidden(false,
                                                              animated: true)
        }
    }
    
    func setNavigationBarShadow(color: UIColor,
                                opacity: Float = 0,
                                radius: CGFloat = 0,
                                offset: CGSize = .zero) {
        self.navigationController?.navigationBar.clipsToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = color.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = opacity
        self.navigationController?.navigationBar.layer.shadowRadius = radius
        self.navigationController?.navigationBar.layer.shadowOffset = offset
    }
    
    func setNavigationBarBackBarButtonItem() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = Colors.darkGray
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrowLeft")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrowLeft")
    }
    
    func setNavigationBarTitle(title: String?){
        self.navigationItem.title = title
        
        if #available(iOS 16, *) {
            self.navigationController?.navigationBar.setNeedsLayout()
        }
    }
    
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    func showProgressHUD() {
        var isShown = false
        for item in self.view.subviews
            where item.restorationIdentifier == self.className {
                isShown = true
        }
        if !isShown {
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0,
                                                                          y: 0,
                                                                          width: 40,
                                                                          height: 40))
            activityIndicator.restorationIdentifier = self.className
            activityIndicator.style = .whiteLarge
            activityIndicator.color = Colors.blue
            activityIndicator.center = CGPoint(x: UIScreen.main.bounds.width / 2,
                                               y: UIScreen.main.bounds.height / 2)
            view.addSubview(activityIndicator)
            DispatchQueue.main.async {
                activityIndicator.startAnimating()
            }
        }
    }

    func hideProgressHUD(){
        for item in self.view.subviews
            where item.restorationIdentifier == self.className {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                item.removeFromSuperview()
            }
        }
    }
    
}
