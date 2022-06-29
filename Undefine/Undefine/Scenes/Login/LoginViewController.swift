//
//  LoginViewController.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import UIKit
import MGArchitecture
import RxSwift
import RxCocoa
import Reusable
import Then

final class LoginViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginView: LoginView!
    
    // MARK: - Properties
    
    var viewModel: LoginViewModel!
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        loginView.delegate = self
    }
    
    func bindViewModel() {
        let input = LoginViewModel.Input(loginTap: loginView.btnLogin.rx.tap.asDriver(),
                                         name: loginView.userNameTextfield.rx.text.orEmpty.asDriver(),
                                         pass: loginView.passwordTextfield.rx.text.orEmpty.asDriver())
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.$isLoginEnabled
            .asDriver()
            .drive(loginView.btnLogin.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.$isLoading
            .asDriver()
            .drive(rx.isLoading)
            .disposed(by: disposeBag)
        
        output.$error
            .asDriver()
            .unwrap()
            .drive(rx.error)
            .disposed(by: disposeBag)
    }
}

extension LoginViewController: LoginViewDelegate {
    func textfieldEditing(textfield: UITextField) {
        print(textfield.text)
    }
}

// MARK: - Binders
extension LoginViewController {
    
}

// MARK: - StoryboardSceneBased
extension LoginViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.login
}
