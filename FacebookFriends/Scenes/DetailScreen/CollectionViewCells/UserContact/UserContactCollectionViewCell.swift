//
//  UserContactCollectionViewCell.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit

final class UserContactCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var seperatorView: UIView!
    
    @IBOutlet weak var phoneStackView: UIStackView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    
    @IBOutlet weak var cellPhoneStackView: UIStackView!
    @IBOutlet weak var cellPhoneLabel: UILabel!
    @IBOutlet weak var cellPhoneButton: UIButton!
    
    @IBOutlet weak var emailStackView: UIStackView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    
    private weak var delegate: UserCollectionViewCellsDelegate?
    private var contactModel: UserContactModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    @IBAction func phoneButtonPressed(_ sender: Any) {
        delegate?.didPressButton(buttonType: .phone(contactModel?.phone ?? ""))
    }
    
    @IBAction func cellPhoneButtonPressed(_ sender: Any) {
        delegate?.didPressButton(buttonType: .cellPhone(contactModel?.cellPhone ?? ""))
    }
    
    @IBAction func emailButtonPressed(_ sender: Any) {
        delegate?.didPressButton(buttonType: .email(contactModel?.email ?? ""))
    }
    
    private func setInnerUI(with model: UserContactModel) {
        phoneButton.isHidden = model.phone == nil
        cellPhoneButton.isHidden = model.cellPhone == nil
        emailButton.isHidden = model.email == nil
        
        phoneLabel.text = model.phone ?? "-"
        cellPhoneLabel.text = model.cellPhone ?? "-"
        emailLabel.text = model.email ?? "-"
    }
    
}

extension UserContactCollectionViewCell: Populatable {
    func populate(with model: Any?) {
        guard let item = model as? UserContactModel
        else { return }
        
        contactModel = item
        setInnerUI(with: item)
    }
    
    func setDelegate(delegate: UserCollectionViewCellsDelegate) {
        self.delegate = delegate
    }
    
}
