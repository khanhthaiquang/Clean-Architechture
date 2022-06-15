//
//  AppViewModel.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct AppViewModel {
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType
}

// MARK: - ViewModel
extension AppViewModel: ViewModel {
    struct Input {
        let load: Driver<Void>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        input.load
            .drive(onNext: self.navigator.toMain)
            .disposed(by: disposeBag)
        
        return Output()
    }
}
