//
//  LoginView.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import UIKit
import MaterialComponents
import RxSwift

class LoginView: UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var userNameTextfield: MDCOutlinedTextField!
    @IBOutlet weak var passwordTextfield: MDCOutlinedTextField!
    @IBOutlet weak var btnLogin: UIButton!
        
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
        
    }
}
