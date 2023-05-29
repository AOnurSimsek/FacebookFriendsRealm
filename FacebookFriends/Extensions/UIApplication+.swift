//
//  UIApplication+.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 123456789
            let keyWindow = UIApplication.shared.connectedScenes
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows.first

            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
                let statusBarUIView = UIView(frame: height)
                statusBarUIView.tag = tag
                statusBarUIView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)

                keyWindow?.addSubview(statusBarUIView)
                return statusBarUIView
            }
        } else {
            return value(forKey: "statusBar") as? UIView
        }
    }
    
}
