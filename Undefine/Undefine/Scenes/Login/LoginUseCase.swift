//
//  LoginUseCase.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import RxSwift

protocol LoginUseCaseType {
    func doLoggin(_ username: String, _ password: String)
    func validateUserName(_ username: String) -> Bool
    func validatePassword(_ password: String) -> Bool
}

struct LoginUseCase: LoginUseCaseType, LoginUseCaseValidate, LogginIn {
    var loginGateWayType: LoginGateWayType
}
