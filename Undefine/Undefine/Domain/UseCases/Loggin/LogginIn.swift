//
//  LogginIn.swift
//  Undefine
//
//  Created by KhanhTQ on 23/06/2022.
//

import Foundation

protocol LogginIn {
    var loginGateWayType: LoginGateWayType {get}
}

extension LogginIn {
    func doLoggin(_ username: String, _ password: String) {
        
    }
}
