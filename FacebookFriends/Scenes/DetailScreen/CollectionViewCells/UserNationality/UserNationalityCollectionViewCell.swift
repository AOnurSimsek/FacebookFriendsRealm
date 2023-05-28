//
//  UserNationalityCollectionViewCell.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit

final class UserNationalityCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var wikipediaButton: UIButton!
    
    private weak var delegate: UserCollectionViewCellsDelegate?
    private var countryName: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.makeFullScreenWidth()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @IBAction func didPressButton(_ sender: Any) {
        delegate?.didPressButton(buttonType: .wikipedia(countryName))
    }
    
}

extension UserNationalityCollectionViewCell: Populatable {
    func populate(with model: Any?) {
        guard let item = model as? String,
              let countryModel: Iso3166_1a2 = .init(rawValue: item)
        else {
            countryLabel.text = model as? String
            return
        }
        
        countryName = countryModel.country
        countryLabel.text = countryName + " " +  countryModel.flag
    }
    
    func setDelegate(delegate: UserCollectionViewCellsDelegate) {
        self.delegate = delegate
    }
    
}
