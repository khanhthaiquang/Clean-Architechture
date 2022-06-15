//
//  AppNavigator.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import UIKit

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow
    
    func toMain() {
        let nav = UINavigationController()
        nav.navigationBar.isHidden = true
        let vc: LoginViewController = assembler.resolve(navigationController: nav)
        nav.viewControllers.append(vc)
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
