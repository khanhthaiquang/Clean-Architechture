//
//  UIViewController+.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showError(message: String, completion: (() -> Void)? = nil) {
        let ac = UIAlertController(title: "Error",
                                   message: message,
                                   preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
    func showAutoCloseMessage(image: UIImage?,
                              title: String?,
                              message: String?,
                              interval: TimeInterval = 2,
                              completion: (() -> Void)? = nil) {
        if let image = image {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = .customView
            hud.customView = UIImageView(image: image)
            hud.label.text = title
            hud.detailsLabel.text = message
            
            DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                MBProgressHUD.hide(for: self.view, animated: true)
                completion?()
            }
        } else {
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .alert)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                ac.dismiss(animated: true, completion: completion)
            }
            
            present(ac, animated: true, completion: nil)
        }
    }
    
    func showToast(message: String,
                   font: UIFont,
                   toastColor: UIColor = .white,
                   backgroundToastColor: UIColor = .black) {
        let toastLabel = UILabel()
        toastLabel.textColor = toastColor
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 6
        toastLabel.backgroundColor = backgroundToastColor
        
        toastLabel.clipsToBounds  =  true
        
        let toastWidth: CGFloat = toastLabel.intrinsicContentSize.width + 16
        let toastHeight: CGFloat = 32
        
        toastLabel.frame = CGRect(x: self.view.frame.width / 2 - (toastWidth / 2),
                                  y: self.view.frame.height - (toastHeight * 3),
                                  width: toastWidth, height: toastHeight)
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1.5, delay: 0.25, options: .autoreverse, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
}
