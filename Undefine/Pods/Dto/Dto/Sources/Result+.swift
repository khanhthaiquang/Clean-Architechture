//
//  Result+.swift
//  Dto
//
//  Created by Tuan Truong on 8/27/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import ValidatedPropertyKit

public typealias ValidationResult = Result<Void, ValidationError>

extension Result where Failure == ValidationError {
    
    public var message: String {
        switch self {
        case .success:
            return ""
        case .failure(let error):
            return error.description
        }
    }
    
    public var isValid: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    public func mapToVoid() -> ValidationResult {
        return self.map { _ in () }
    }
}
