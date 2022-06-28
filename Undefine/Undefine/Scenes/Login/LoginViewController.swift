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
        loginView.btnLogin.rx.tap.subscribe(onNext: { [weak self] a in
            
        }).disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = LoginViewModel.Input()
        let output = viewModel.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - Binders
extension LoginViewController {
    
}

// MARK: - StoryboardSceneBased
extension LoginViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.login
}
