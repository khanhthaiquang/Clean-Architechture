//
//  APIError.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import MGAPIService
import Foundation

struct APIResponseError: APIError {
    let statusCode: Int?
    let message: String
    
    var errorDescription: String? {
        return message
    }
}
