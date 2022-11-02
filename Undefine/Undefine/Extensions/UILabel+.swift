//
//  UILabel+.swift
//  Undefine
//
//  Created by KhánhTQ on 02/11/2022.
//

import Foundation
import UIKit

extension UILabel {
    func setLineSpacing(lineSpacing: CGFloat = 0.0,
                        lineHeightMultiple: CGFloat = 0.0,
                        _ alignment: NSTextAlignment = .left,
                        font: UIFont) {
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode
        
        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSMakeRange(0, attributedString.length))
        
        attributedString.addAttribute(NSAttributedString.Key.font,
                                      value: font,
                                      range: NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}
