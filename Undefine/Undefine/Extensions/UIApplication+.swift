//
//  UIApplication+.swift
//  Undefine
//
//  Created by KhánhTQ on 28/10/2022.
//

import Foundation
import UIKit

extension UIApplication {

    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }

        return viewController
    }

    class func topViewIgnoreNavController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewIgnoreNavController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewIgnoreNavController(presented)
        }

        return viewController
    }
}
