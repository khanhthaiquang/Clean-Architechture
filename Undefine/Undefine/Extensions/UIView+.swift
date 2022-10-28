//
//  UIView+.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get {
            let color = layer.borderColor ?? UIColor.white.cgColor
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    func roundedUsingWidth() {
        cornerRadius = frame.size.width / 2
    }
    
    func roundedUsingHeight() {
        cornerRadius = frame.size.height / 2
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius,
                                                        height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
}

extension UIView {
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "TapViewAssociatedObjectKey_tapViewer"
        static var swipeGestureRecognizer = "SwipeViewAssociatedObjectKey_swipeViewer"
        static var panGestureRecognizer = "PanViewAssociatedObjectKey_panViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    fileprivate typealias ActionPan = ((_ panGesture: UIPanGestureRecognizer) -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    fileprivate var swipeGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.swipeGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let swipeGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.swipeGestureRecognizer) as? Action
            return swipeGestureRecognizerActionInstance
        }
    }
    
    fileprivate var panGestureRecognizerAction: ActionPan? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.panGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let panGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.panGestureRecognizer) as? ActionPan
            return panGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    public func addSwipeGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.swipeGestureRecognizerAction = action
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGestureRecognizer.direction = .right
        self.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    public func addPanGestureRecognizer(action: ((_ panGesture: UIPanGestureRecognizer) -> Void)?) {
        self.isUserInteractionEnabled = true
        self.panGestureRecognizerAction = action
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        self.addGestureRecognizer(panGestureRecognizer)
    }
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    @objc fileprivate func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
        if let action = self.swipeGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    @objc fileprivate func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        if let action = self.panGestureRecognizerAction {
            action?(sender)
        } else {
            print("no action")
        }
    }
}

extension UIView {
    public func logDeinit() {
        print(String(describing: type(of: self)) + " deinit")
    }
}

// MARK: - Handle snapshot UIView
extension UIView {
    func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        return nil
    }

    func snapshot(views: [UIView], size: CGSize) -> UIImage? {
        if views.isEmpty {
            return nil
        }

        UIGraphicsBeginImageContextWithOptions(size, isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        if let context = UIGraphicsGetCurrentContext() {
            context.interpolationQuality = .high
            for view in views {
                view.drawHierarchy(in: view.frame, afterScreenUpdates: false)
            }
            return UIGraphicsGetImageFromCurrentImageContext()
        }

        return nil
    }
}
