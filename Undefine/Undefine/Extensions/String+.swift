//
//  String+.swift
//  Undefine
//
//  Created by KhánhTQ on 28/10/2022.
//

import Foundation
import UIKit
import CommonCrypto

extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

extension String {
    var isSingleEmoji: Bool { count == 1 && containsEmoji }

    var containsEmoji: Bool { contains { $0.isEmoji } }

    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }

    var emojiString: String { emojis.map { String($0) }.reduce("", +) }

    var emojis: [Character] { filter { $0.isEmoji } }

    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
    
    func toInt() -> Int {
        return Int(self) ?? 0
    }
    
    ///String size of label
    func rectSize(font: UIFont, size: CGSize) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        
        let rect = self.boundingRect(with: size,
                                     options: option,
                                     attributes: attributes,
                                     context: nil)
        return rect.size
    }
    
    /// dictionary from json string
    var toDict: [String: Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
    
    var md5: String? {
        guard count > 0 else { return nil }
        
        let cCharArray = cString(using: .utf8)
        var uint8Array = [UInt8](repeating: 0,
                                 count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(cCharArray,
               CC_LONG(cCharArray!.count - 1),
               &uint8Array)
        return uint8Array.reduce("") { $0 + String(format: "%02X", $1)}
    }
    
    var base64Encode: String? {
        guard let codingData = data(using: .utf8) else {
            return nil
        }
        return codingData.base64EncodedString()
    }
    
    var base64Decode: String? {
        guard let decryptionData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return String(data: decryptionData, encoding: .utf8)
    }
}
