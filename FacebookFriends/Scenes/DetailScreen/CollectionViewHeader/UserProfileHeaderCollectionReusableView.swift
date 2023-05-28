//
//  UserProfileHeaderCollectionReusableView.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit

final class UserProfileHeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    private func setUI() {
        profileImageView.addRadius(radius: 10)
        profileImageView.layer.borderColor = Colors.blue.cgColor
        profileImageView.layer.borderWidth = 2
    }
    
}

extension UserProfileHeaderCollectionReusableView: Populatable {
    func populate(with model: Any?) {
        guard let item = model as? UserHeaderModel
        else { return }
        
        profileImageView.setImage(source: .init(string: item.urlString))
        nameLabel.text = item.name
    }
    
}
