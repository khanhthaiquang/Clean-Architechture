//
//  LogginIn.swift
//  Undefine
//
//  Created by KhanhTQ on 23/06/2022.
//

import Foundation
import RxCocoa
import RxSwift

protocol LogginIn {
    var loginGateWayType: LoginGateWayType {get}
}

extension LogginIn {
    func doLoggin(_ username: String, _ password: String) -> Observable<Void> {
        return Observable.create { observer in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: {
                observer.onNext(())
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
}
