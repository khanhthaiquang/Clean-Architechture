//
//  NetworkConnectivity.swift
//  Undefine
//
//  Created by KhánhTQ on 28/10/2022.
//

import Foundation
import Alamofire

class NetworkConnectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
