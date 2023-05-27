//
//  BaseRefreshControl.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit

class BaseRefreshControl: UIRefreshControl {
    
        override var isHidden: Bool {
            get {
                return super.isHidden
            }
            set(hiding) {
                if hiding {
                    guard frame.origin.y >= 0 else { return }
                    super.isHidden = hiding
                } else {
                    guard frame.origin.y < 0 else { return }
                    super.isHidden = hiding
                }
            }
        }
    
        override var frame: CGRect {
            didSet {
                isHidden = (frame.origin.y > 0)
            }
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let originalFrame = frame
        frame = originalFrame
    }
}
