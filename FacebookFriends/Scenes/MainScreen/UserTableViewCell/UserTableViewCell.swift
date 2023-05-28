//
//  UserTableViewCell.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 26.05.2023.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
        
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
    }
    
    private func setupUI() {
        profileImageView.addRadius(radius: 8)
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = Colors.lightGray.cgColor
    }
    
}

extension UserTableViewCell: Populatable {
    func populate(with model: Any?) {
        guard let item = model as? UserResponseModel
        else { return }
        
        nameLabel.text = item.name?.getUSerFullName()
        profileImageView.setImage(source: .init(string: item.picture?.medium ?? ""))
    }
}
