//
//  APIOutput.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import ObjectMapper
import MGAPIService

class APIOutput: APIOutputBase {  // swiftlint:disable:this final_class
    var message: String?
    
    override func mapping(map: Map) {
        message <- map["message"]
    }
}
