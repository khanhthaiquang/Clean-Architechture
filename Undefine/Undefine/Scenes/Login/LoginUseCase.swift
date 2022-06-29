//
//  LoginUseCase.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import RxSwift
import Dto
import RxCocoa

protocol LoginUseCaseType {
    func doLoggin(_ username: String, _ password: String) -> Observable<Void>
    func validateUserName(_ username: String) -> Bool
    func validatePassword(_ password: String) -> Bool
    func isEnableLogin(_ password: String, _ username: String) -> Bool
}

struct LoginUseCase: LoginUseCaseType, LoginUseCaseValidate, LogginIn {
    var loginGateWayType: LoginGateWayType
}
