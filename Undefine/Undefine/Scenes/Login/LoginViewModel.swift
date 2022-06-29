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
        let name: Driver<String>
        let pass: Driver<String>
    }
    
    struct Output {
           @Property var usernameValidationMessage = ""
           @Property var passwordValidationMessage = ""
           @Property var isLoginEnabled = true
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

        let isloading = activityIndicator.asDriver()
        
        isloading.drive(output.$isLoading)
            .disposed(by: disposeBag)
        
        let userNameValidation = Driver.combineLatest(input.name, input.loginTap)
            .map{$0.0}
            .map(useCase.validateUserName(_:))
        
     
        
        let passValidation = Driver.combineLatest(input.pass, input.loginTap)
            .map{$0.0}
            .map(useCase.validatePassword(_:))
        
        let validation = Driver.and(
            userNameValidation.map{$0},
            passValidation.map{$0}
        ).startWith(true)
        
        let isLoginEnable = Driver.merge(validation,isloading.not())
        
        isLoginEnable
            .drive(output.$isLoginEnabled)
            .disposed(by: disposeBag)
        
        input.loginTap
            .withLatestFrom(isLoginEnable)
            .filter{$0}
            .withLatestFrom(Driver.combineLatest(input.name, input.pass))
            .flatMapLatest{ username, password -> Driver<Void> in
                self.useCase.doLoggin(username, password)
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: {
                print("move screen")
            })
            .drive()
            .disposed(by: disposeBag)
        return output
    }
}
