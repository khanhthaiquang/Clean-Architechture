//
//  LoginView.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import UIKit
import MaterialComponents
import RxSwift

protocol LoginViewDelegate {
    func textfieldEditing(textfield: UITextField)
}

class LoginView: UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var userNameTextfield: MDCOutlinedTextField!
    @IBOutlet weak var passwordTextfield: MDCOutlinedTextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var delegate: LoginViewDelegate?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let bundle = Bundle(for: LoginView.self)
        bundle.loadNibNamed("LoginView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        roundCorners(corners: [.topLeft, .topRight], radius: 12.0)
        
        userNameTextfield.initBasic(with: "User name")
        passwordTextfield.initBasic(with: "Password")
        
        userNameTextfield.delegate = self
        passwordTextfield.delegate = self
        
        userNameTextfield.addTarget(self, action: #selector(textfieldEditing(sender:)), for: .allEditingEvents)
        passwordTextfield.addTarget(self, action: #selector(textfieldEditing(sender:)), for: .allEditingEvents)
    }
    
    @objc private func textfieldEditing(sender: UITextField) {
        if let delegate = delegate {
            delegate.textfieldEditing(textfield: sender)
        }
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.resignFirstResponder()
    }
}
