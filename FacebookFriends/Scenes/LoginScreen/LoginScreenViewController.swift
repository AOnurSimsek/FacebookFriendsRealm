//
//  LoginScreenViewController.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 26.05.2023.
//

import UIKit

final class LoginScreenViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var innerCardView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var logoTitleLabel: UILabel!
    @IBOutlet weak var usernameView: SlidingTextField!
    @IBOutlet weak var passwordView: SlidingTextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
        setCardView()
        hideKeyboardWhenTappedAround()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.userNameChecker.bind { [weak self] isValid in
            guard let _self = self,
                  let _isValid = isValid
            else { return }
            
            _self.usernameView.setColor(isValid: _isValid)
        }
        
        viewModel.loginError.bind { [weak self] error in
            guard let _self = self,
                  let _error = error
            else { return }
            
            _self.showAlert(message: _error.description)
        }
    }
    
    private func setTextFields() {
        usernameView.setTypeandDelegate(type: .username,
                                        delegate: self)
        passwordView.setTypeandDelegate(type: .password,
                                        delegate: self)
    }
    
    private func setCardView() {
        innerCardView.addRadius(radius: 10)
        loginButton.addRadius(radius: 6)
        innerCardView.addBasicDropShadow(offset: .init(width: 8, height: 16),
                                         color: .black,
                                         radius: 8,
                                         opacity: 0.3)
    }
    
    @IBAction func didPressLoginButton(_ sender: UIButton) {
        viewModel.didPressLoginButton()
    }
    
}

extension LoginScreenViewController: SlidingTextFieldDelegate {
    func keyboardStatus(status: KeyboardStatus,
                        keyboardHeight: CGFloat) {
        switch status {
        case .opened:
            self.view.frame.origin.y -= (self.view.frame.origin.y == 0) ? keyboardHeight : 0
        case .closed:
            self.view.frame.origin.y = 0
        }
    }
    
    func editingDidfinish(text: String,
                          textFieldType: TextFieldType) {
        switch textFieldType {
        case .username:
            viewModel.checkUserName(userName: text)
        case .password:
            viewModel.setPassword(text: text)
        }
    }
}
