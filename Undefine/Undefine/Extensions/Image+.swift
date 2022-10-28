//
//  Image+.swift
//  Undefine
//
//  Created by KhánhTQ on 28/10/2022.
//

import UIKit

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio
            ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            : CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let returnImage = newImage else { return self }
        return returnImage
    }
    
    public class func image(size: CGSize, drawingBlock:(CGContext, CGRect) -> Void) -> UIImage? {
        guard size.equalTo(CGSize()) == false else {
            return nil
        }
        
        let rect = CGRect(x:0, y:0, width:size.width, height:size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.clear(rect)
        
        drawingBlock(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    public class func image(color:UIColor, size:CGSize) -> UIImage? {
        guard size.equalTo(CGSize()) == false else {
            return nil
        }
        
        return UIImage.image(size: size) { (context:CGContext, rect:CGRect) in
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
    }
}

