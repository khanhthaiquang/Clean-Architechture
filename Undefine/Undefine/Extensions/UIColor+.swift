//
//  UIColor+.swift
//  Undefine
//
//  Created by KhánhTQ on 28/10/2022.
//

import Foundation
import UIKit

extension UIColor {
    //let purple = UIColor(hexStr: "0xAB47BC")
    convenience init(hexStr: String) {
        let hex = hexStr.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

    convenience init(hexInt: Int, alpha: CGFloat = 1.0) {
        let components = UIColor.components(hexInt: hexInt)
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }

    private static func components(hexInt: Int) -> (R: CGFloat, G: CGFloat, B: CGFloat) {
        return (
            R: CGFloat((hexInt >> 16) & 0xff) / 255,
            G: CGFloat((hexInt >> 08) & 0xff) / 255,
            B: CGFloat((hexInt >> 00) & 0xff) / 255
        )
    }
}
