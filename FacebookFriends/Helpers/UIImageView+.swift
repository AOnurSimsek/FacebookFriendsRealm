//
//  UIImageView+.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(source: URL?) {
        self.kf.setImage(with: source,
                         placeholder: UIImage(named: "profilePlaceholder"),
                         options: [
                             .transition(.fade(0.5)),
                             .cacheOriginalImage
                         ])
    }
}
