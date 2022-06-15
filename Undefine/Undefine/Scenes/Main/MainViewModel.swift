//
//  MainViewModel.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import RxSwift
import RxCocoa
import MGArchitecture

struct MainViewModel {
    let navigator: MainNavigatorType
    let useCase: MainUseCaseType
}

// MARK: - ViewModel
extension MainViewModel: ViewModel {
    struct Input {
        let load: Driver<Void>
    }
    
    struct Output {

    }

    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()

        return output
    }
}
