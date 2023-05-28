//
//  UICollectionView+.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit

extension UICollectionView {
    func registerNib<T>(withClassAndIdentifier: T.Type) {
        let classAndIdentifier = String(describing: withClassAndIdentifier.self)
        let nib = UINib.init(nibName: classAndIdentifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: classAndIdentifier)
    }
    
    func registerNibs<T>(withClassesAndIdentifiers: [T.Type]) {
        withClassesAndIdentifiers.forEach{ registerNib(withClassAndIdentifier: $0) }
    }
    
    func registerHeader<T: UICollectionReusableView>(withClassAndIdentifiers: T.Type) {
        let name: String = .init(describing: withClassAndIdentifiers.self)
        let nib: UINib = .init(nibName: .init(describing: name),
                               bundle: nil)
        self.register(nib,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: name)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(withClassAndIdentifier: T.Type, for indexPath: IndexPath) -> T{
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: withClassAndIdentifier.self), for: indexPath) as? T
        else {
            fatalError("Could not dequeue cell with identifier: \(String(describing: withClassAndIdentifier.self))")
        }
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(withClassAndIdentifier: T.Type, for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                          withReuseIdentifier: String(describing: withClassAndIdentifier.self),
                                                          for: indexPath) as? T
        else {
            fatalError("Could not dequeue cell with identifier: \(String(describing: withClassAndIdentifier.self))")
        }
        
        return view
    }
    
    func registerNib<T>(withClassAndIdentifier: T.Type, kind: String) {
        let classAndIdentifier = String(describing: withClassAndIdentifier.self)
        let nib = UINib.init(nibName: classAndIdentifier, bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: classAndIdentifier)
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionViewCell>(kind: String, withClassAndIdentifier: T.Type, for indexPath: IndexPath) -> T{
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: withClassAndIdentifier.self), for: indexPath) as? T
        else {
            fatalError("Could not dequeueReusableSupplementaryView with identifier: \(String(describing: withClassAndIdentifier.self))")
        }
        return cell
    }
}
