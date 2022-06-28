//
//  LoginGeteWay.swift
//  Undefine
//
import Foundation
import RxSwift

protocol LoginGateWayType {
    func Login() -> Observable<Void>
}

struct LoginGateWay: LoginGateWayType {
    func Login() -> Observable<Void> {
        
    }
}
