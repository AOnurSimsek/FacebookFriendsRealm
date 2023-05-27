//
//  UITableView+.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit

extension UITableView {
    func registerNib<T>(withClassAndIdentifier: T.Type) {
        let classAndIdentifier = String(describing: withClassAndIdentifier.self)
        let nib = UINib.init(nibName: classAndIdentifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: classAndIdentifier)
    }
    
    func dequeueReusableCellWithoutSelectionStyle<T: UITableViewCell>(withClassAndIdentifier: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: withClassAndIdentifier.self), for: indexPath) as? T
        else {  fatalError("Could not dequeue cell with identifier: \(String(describing: withClassAndIdentifier.self))") }
        
        cell.selectionStyle = .none
        return cell
    }
}
