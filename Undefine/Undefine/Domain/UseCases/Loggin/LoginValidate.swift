//
//  LoginValidate.swift
//  Undefine
//
//  Created by KhanhTQ on 23/06/2022.
//

import Foundation

protocol LoginUseCaseValidate {
    
}

extension LoginUseCaseValidate {
    func validateUserName(_ username: String) -> Bool {
        return username.isEmpty
    }
    
    func validatePassword(_ password: String) -> Bool {
        return password.count >= 8
    }
}
