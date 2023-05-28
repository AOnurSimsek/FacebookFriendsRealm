//
//  UserLocationCollectionViewCell.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit

final class UserLocationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var mapButton: UIButton!
    
    private weak var delegate: UserCollectionViewCellsDelegate?
    private var coordinateModel: CoordinateResponseModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.makeFullScreenWidth()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    @IBAction func didPressMapButton(_ sender: Any) {
        delegate?.didPressButton(buttonType: .map(coordinateModel))
    }
    
    private func setInnerUI(with model: LocationResponseModel) {
        mapButton.isHidden = model.coordinates == nil
        
        topLabel.text = String(model.street?.number ?? 0) + " " + (model.street?.name ?? "-")
        middleLabel.text = (model.state ?? " ") + " - " + (model.city ?? " ")
        bottomLabel.text = (model.country ?? "-")
    }
    
}

extension UserLocationCollectionViewCell: Populatable {
    func populate(with model: Any?) {
        guard let item = model as? LocationResponseModel
        else { return }
        
        coordinateModel = item.coordinates
        setInnerUI(with: item)
    }
    
    func setDelegate(delegate: UserCollectionViewCellsDelegate) {
        self.delegate = delegate
    }
}
