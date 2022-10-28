//
//  Date+.swift
//  Undefine
//
//  Created by KhánhTQ on 28/10/2022.
//

import Foundation

extension Date {
    func isLaterThan(date: Date) -> Bool {
        let result = self.compare(date)
        return result == .orderedDescending
    }

    func isEqualOrLaterThan(date: Date) -> Bool {
        let result = self.compare(date)
        return result == .orderedDescending || result == .orderedSame
    }

    func isEarlierThan(date: Date) -> Bool {
        let result = self.compare(date)
        return result == .orderedAscending
    }

    func isEqualOrEarlierThan(date: Date) -> Bool {
        let result = self.compare(date)

        return result == .orderedAscending || result == .orderedSame
    }

    func isEqual(date: Date) -> Bool {
        let result = self.compare(date)
        return result == .orderedSame
    }
}
