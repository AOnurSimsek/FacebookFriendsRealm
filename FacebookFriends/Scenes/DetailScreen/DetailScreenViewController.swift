//
//  DetailScreenViewController.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit

final class DetailScreenViewController: UIViewController {
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: self.collectionViewLayout)
        collectionView.backgroundColor = Colors.backgrounGray
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let viewModel: DetailScreenViewModel
    
    init(viewModel: DetailScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        bindViewModel()
        setNavigationBarStyle(type: .color,
                              color: .white,
                              isBarShadowOpened: false)
        viewModel.loadUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUI()
    }
    
    private func setUI() {
        setNavigationBarStyle(type: .color,
                              color: .white,
                              isBarShadowOpened: false)
    }
    
    private func bindViewModel() {
        viewModel.appState.bind { [weak self] state in
            switch state {
            case .reload:
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .error(let errorType):
                self?.showAlert(message: errorType.description)
            default:
                return
            }
        }
    }
    
    
}

extension DetailScreenViewController: UICollectionViewDelegate,
                                      UICollectionViewDataSource,
                                      UICollectionViewDelegateFlowLayout {
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.constraintFillSuperview()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = false
        
        collectionView.contentInset = .init(top: 0,
                                            left: 0,
                                            bottom: 50,
                                            right: 0)
        
        let nibs: [UICollectionViewCell.Type] = [UserContactCollectionViewCell.self,
                                                 UserDateofBirthCollectionViewCell.self,
                                                 UserLocationCollectionViewCell.self,
                                                 UserNationalityCollectionViewCell.self]
        collectionView.registerNibs(withClassesAndIdentifiers: nibs)
        collectionView.registerHeader(withClassAndIdentifiers: UserProfileHeaderCollectionReusableView.self)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getSectionCount()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(withClassAndIdentifier: UserProfileHeaderCollectionReusableView.self,
                                                                         for: indexPath)
        headerView.populate(with: viewModel.getUserHeaderModel())
        headerView.addBasicDropShadow(offset: .init(width: 0,
                                                    height: 10),
                                      radius: 10,
                                      opacity: 0.15)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let currentSection = viewModel.getSection(for: section)
        let size: CGSize = (currentSection == .contact(nil)) ? .init(width: UIScreen.main.bounds.width, height: 200) : .zero
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentSection = viewModel.getSection(for: indexPath.section)
        switch currentSection {
        case .contact(let userContactModel):
            let cell = collectionView.dequeueReusableCell(withClassAndIdentifier: UserContactCollectionViewCell.self,
                                                          for: indexPath)
            cell.populate(with: userContactModel)
            cell.setDelegate(delegate: self)
            return cell
            
        case .dateofBirth(let dateofBirtModel):
            let cell = collectionView.dequeueReusableCell(withClassAndIdentifier: UserDateofBirthCollectionViewCell.self,
                                                          for: indexPath)
            cell.populate(with: dateofBirtModel)
            return cell
            
        case .location(let locationModel):
            let cell = collectionView.dequeueReusableCell(withClassAndIdentifier: UserLocationCollectionViewCell.self,
                                                          for: indexPath)
            cell.populate(with: locationModel)
            cell.setDelegate(delegate: self)
            return cell
            
        case .nationality(let nationality):
            let cell = collectionView.dequeueReusableCell(withClassAndIdentifier: UserNationalityCollectionViewCell.self,
                                                          for: indexPath)
            cell.populate(with: nationality)
            cell.setDelegate(delegate: self)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getCellHeight(for: indexPath.section)
    }
    
}

extension DetailScreenViewController: UserCollectionViewCellsDelegate {
    func didPressButton(buttonType: UserCollectionViewCellButtonType) {
        viewModel.didPressedButton(type: buttonType)
    }
    
}
