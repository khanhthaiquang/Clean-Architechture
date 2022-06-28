//
//  LoginNavigator.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import UIKit
import RxCocoa
import RxSwift

protocol LoginNavigatorType {
    func onLogin(name: String, pass: String) -> Driver<Void>
}

struct LoginNavigator: LoginNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func onLogin(name: String, pass: String) -> Driver<Void> {
        return Observable<Void>.create ({ (observer) -> Disposable in
            let alert = UIAlertController(
                title: "Từ Từ",
                message: "Chức năng này chưa được làm á.",
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Vâng", style: .cancel) { (_) in
                observer.onCompleted()
            }
            alert.addAction(okAction)
            self.navigationController.present(alert, animated: false, completion: nil)
            
            return Disposables.create {
                alert.dismiss(animated: true, completion: nil)
            }
        })
            .asDriverOnErrorJustComplete()
    }
}
