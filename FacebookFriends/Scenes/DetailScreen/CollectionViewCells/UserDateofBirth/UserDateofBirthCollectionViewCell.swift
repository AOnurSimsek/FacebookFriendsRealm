//
//  UserDateofBirthCollectionViewCell.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit

final class UserDateofBirthCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dateStackView: UIStackView!
    @IBOutlet weak var ageStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.makeFullScreenWidth()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}

extension UserDateofBirthCollectionViewCell: Populatable {
    func populate(with model: Any?) {
        guard let item = model as? DateOfBirthResponseModel
        else { return }
        
        dateLabel.text = (item.date ?? "").toOtherDate()
        ageLabel.text = String(item.age ?? 0)
    }
    
}
