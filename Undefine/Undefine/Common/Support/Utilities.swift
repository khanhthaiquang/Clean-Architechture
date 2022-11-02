//
//  Utilities.swift
//  Undefine
//
//  Created by KhánhTQ on 02/11/2022.
//

import Foundation
import UIKit
import CoreTelephony

class Utilities {
    static func getDeviceID() -> String {
        if let identifierForVendor = UIDevice.current.identifierForVendor {
            return identifierForVendor.uuidString
        }
        return ""
    }
    
    static func getScreenScale() -> CGFloat {
        return UIScreen.main.scale
    }
    
    static func openURLWithSafariBrowser(_ url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    static func openAppPreferences() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        openURLWithSafariBrowser(url)
    }
    
    static func openAppStore(with appID: String) {
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appID)") else { return }
        openURLWithSafariBrowser(url)
    }
    
    static func openYoutubeApp(with url: String) {
        guard let appUrl = URL(string: url), let youtubeAppString = URL(string: "youtube://") else { return }
        if appUrl.host?.contains("www.youtube.com") ?? false, UIApplication.shared.canOpenURL(youtubeAppString) {
            openURLWithSafariBrowser(appUrl)
        } else {
            openAppStore(with: "")
        }
    }
    
    static func getCurrentLocale() -> Locale {
        if let currentLocal = Bundle.main.preferredLocalizations.first {
            return Locale(identifier: currentLocal)
        }
        return Locale.current
    }
    
    static var widthScreenRatio: CGFloat {
        return UIScreen.main.bounds.width / 375.0
    }
    
    static var heightScreenRatio: CGFloat {
        return UIScreen.main.bounds.width / 667.0
    }
}

// MARK: - SafeArea Padding
extension Utilities {
    static func getBottomSafeAreaPadding() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets.bottom ?? 0.0
        }
        return 0.0
    }
    
    static func getTopSafeAreaPadding() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets.top ?? 0.0
        }
        return 0.0
    }
}

// MARK: - JSON
extension Utilities {
    static func json(from object: Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
