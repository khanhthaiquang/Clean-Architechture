//
//  GatewaysAssembler.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import UIKit

protocol GatewaysAssembler {
    func resolve() -> LoginGateWayType
}

extension GatewaysAssembler where Self: DefaultAssembler {
    func resolve() -> LoginGateWayType {
        LoginGateWay()
    }
}
