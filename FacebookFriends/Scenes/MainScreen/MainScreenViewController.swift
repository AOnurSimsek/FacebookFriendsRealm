//
//  MainScreenViewController.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 26.05.2023.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let viewModel: MainScreenViewModelProtocol
    
    init(viewModel: MainScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        viewModel.getUserData(starter: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        setNavigationBarStyle(type: .color,
                              color: Colors.blue,
                              isBarShadowOpened: true,
                              title: "Friends")
        setNavigationBarBackBarButtonItem()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "logoutIcon"),
                                                                   style: .plain,
                                                                   target: self,
                                                                   action: #selector(logoutButtonPressed))
    }
    
    @objc func logoutButtonPressed() {
        viewModel.didPressedLogout()
    }
    
    private func bindViewModel() {
        viewModel.screenState.bind { [weak self] state in
            switch state {
            case .showProgressHUD:
                self?.showProgressHUD()
            
            case .hideProgressHUD:
                self?.hideProgressHUD()
                
            case .hideRefreshHUD:
                self?.refreshControl.endRefreshing()
            
            case .dataReached:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .error(let errorDescription):
                self?.showAlert(message: errorDescription)
            
            default:
                return
            }
            
        }
        
    }
    
}

// MARK: - TableviewStuff
extension MainScreenViewController: UITableViewDataSource,
                                    UITableViewDelegate {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.constraintFillSuperview()
        tableView.addSubview(refreshControl)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.showsVerticalScrollIndicator = false
        
        tableView.separatorColor = Colors.lightGray
        tableView.separatorInset = UIEdgeInsets(top: 0,
                                                left: 20,
                                                bottom: 0,
                                                right: 20)
        tableView.contentInset = .init(top: 0,
                                       left: 0,
                                       bottom: 20,
                                       right: 0)
        tableView.tableFooterView = .none
        tableView.tableHeaderView = .none
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.estimatedRowHeight = 80
        
        tableView.registerNib(withClassAndIdentifier: UserTableViewCell.self)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        viewModel.getUserData(starter: .refresh)
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.getUserModelCount()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithoutSelectionStyle(withClassAndIdentifier: UserTableViewCell.self,
                                                                      for: indexPath)
        cell.populate(with: viewModel.getUserModel(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectUser(at: indexPath.row,
                                source: self)
    }
    
}
