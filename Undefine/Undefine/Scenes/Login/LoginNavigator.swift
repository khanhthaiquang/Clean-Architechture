//
//  LoginNavigator.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import UIKit

protocol LoginNavigatorType {
    
}

struct LoginNavigator: LoginNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
