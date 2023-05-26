//
//  SlidingTextField.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 26.05.2023.
//

import UIKit

enum TextFieldType {
    case username
    case password
    
    var placeHolderText: String {
        switch self {
        case .username:
            return "Username"
        case .password:
            return "Password"
        }
    }
}
enum PlaceholderLabelPlacement {
    case top
    case middle
}

enum KeyboardStatus {
    case opened
    case closed
}

protocol SlidingTextFieldDelegate: AnyObject {
    func editingDidfinish(text: String,
                          textFieldType: TextFieldType)
    func keyboardStatus(status: KeyboardStatus,
                        keyboardHeight: CGFloat)
}

final class SlidingTextField: UIView {
    
    @IBOutlet weak var textField: UITextField!
    
    private lazy var placeholderLabel: InsetLabel = {
       let label = InsetLabel()
        label.contentInsets = .init(top: 0,
                                    left: 5,
                                    bottom: 0,
                                    right: 5)
        label.backgroundColor = .white
        label.layer.zPosition = 1
        label.font = .systemFont(ofSize: 14,
                                 weight: .regular)
        label.textColor = Colors.lightGray
        label.frame = CGRect(x: 15,
                             y: (self.frame.height/2) - 7.5,
                             width: 20,
                             height: 15)
        label.textAlignment = .left
        self.addSubview(label)
       return label
    }()
    
    private weak var delegate: SlidingTextFieldDelegate?
    private var type: TextFieldType?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ownFirstNib()
        setupTextField()
        addNotificationObserver()
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func setupTextField() {
        textField.setLeftPaddingPoints(10)
        textField.setRightPaddingPoints(10)
        textField.addRadius(radius: 6)
        textField.layer.borderWidth = 1
        textField.delegate = self
        setColor(isValid: true)
    }
    
    private func setPlaceholderPlacement(type: PlaceholderLabelPlacement) {
        switch type {
        case .top:
            UIView.animate(withDuration: 0.3) {
                self.placeholderLabel.frame = CGRect(x: 15,
                                                     y: 7.5,
                                                     width: 20,
                                                     height: 15)
                self.placeholderLabel.sizeToFit()
            }
        case .middle:
            UIView.animate(withDuration: 0.3) {
                self.placeholderLabel.frame = CGRect(x: 15,
                                                     y: (self.frame.height/2) - 7.5,
                                                     width: 20,
                                                     height: 15)
                self.placeholderLabel.sizeToFit()
            }
        }
    }
    
    func setColor(isValid: Bool) {
        textField.textColor = isValid ? Colors.darkGray : Colors.red
        textField.layer.borderColor = isValid ? Colors.lightGray.cgColor : Colors.red.cgColor
        placeholderLabel.textColor = isValid ? Colors.lightGray : Colors.red
    }
    
    func setTypeandDelegate(type: TextFieldType,
                            delegate: SlidingTextFieldDelegate) {
        self.delegate = delegate
        self.type = type
        placeholderLabel.text = type.placeHolderText
        placeholderLabel.sizeToFit()
        textField.isSecureTextEntry = type == .password
    }
    
    func getText() -> String {
        return textField.text ?? ""
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
      
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           textField.isEditing {
            delegate?.keyboardStatus(status: .opened,
                                     keyboardHeight: keyboardSize.height)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        delegate?.keyboardStatus(status: .closed,
                                 keyboardHeight: 0)
    }
}

// MARK: - TextFieldDelegate
extension SlidingTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setPlaceholderPlacement(type: .top)
        setColor(isValid: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty,
              let _type = type
        else {
            setPlaceholderPlacement(type: .middle)
            return
        }
        
        delegate?.editingDidfinish(text: text,
                                   textFieldType: _type)
    }
}
