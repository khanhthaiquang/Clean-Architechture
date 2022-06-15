//
//  MainNavigator.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import UIKit

protocol MainNavigatorType {

}

struct MainNavigator: MainNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}

