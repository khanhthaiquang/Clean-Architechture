//
//  LoginViewModel.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import MGArchitecture
import RxSwift
import RxCocoa
import Alamofire

struct LoginViewModel {
    let navigator: LoginNavigatorType
    let useCase: LoginUseCaseType
}

// MARK: - ViewModel
extension LoginViewModel: ViewModel {
    struct Input {
        let loginTap: Driver<Void>
        let name: String
        let pass: String
    }
    
    struct Output {
        @Property var isLoading = false
        @Property var error: Error?
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        let activityIndicator = ActivityIndicator()
        
        let errorTracker = ErrorTracker()
        errorTracker
            .drive(output.$error)
            .disposed(by: disposeBag)

        let isLoading = activityIndicator.asDriver()
        isLoading
            .drive(output.$isLoading)
            .disposed(by: disposeBag)
        
        input.loginTap.flatMapLatest { _ -> Driver<String> in
            return navigator.onLogin(name: input.name, pass: input.pass).drive(onNext: <#T##((Element) -> Void)?#>, onCompleted: <#T##(() -> Void)?#>, onDisposed: <#T##(() -> Void)?#>)
        }
        return output
    }
}
