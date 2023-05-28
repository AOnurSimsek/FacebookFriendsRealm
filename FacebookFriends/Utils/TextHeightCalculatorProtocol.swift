//
//  TextHeightCalculatorProtocol.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 29.05.2023.
//

import UIKit

protocol TextHeightCalculatorProtocol { }

extension TextHeightCalculatorProtocol {
    func calculateTextRequiredHeight(text: String?,
                                     labelWidth: CGFloat,
                                     font: UIFont) -> CGFloat{
        guard text != nil && text != ""
        else { return .zero }
        
        let size = CGSize(width: labelWidth, height: .greatestFiniteMagnitude)
        var attributes: [NSAttributedString.Key : NSObject]
        attributes = [NSAttributedString.Key.font: font]
        let estimatedLabelFrame = NSString(string: text!).boundingRect(with: size,
                                                                       options: .usesLineFragmentOrigin,
                                                                       attributes: attributes,
                                                                       context: nil)

       return estimatedLabelFrame.height.rounded(.up)
    }
}
