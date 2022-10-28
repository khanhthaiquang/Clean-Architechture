//
//  Bundle+.swift
//  Undefine
//
//  Created by KhánhTQ on 28/10/2022.
//

import Foundation

extension Bundle {
    var shortVersion: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
