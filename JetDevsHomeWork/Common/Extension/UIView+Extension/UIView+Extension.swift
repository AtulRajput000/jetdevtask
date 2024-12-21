//
//  UIView+Extension.swift
//  JetDevsHomeWork
//
//    20/12/24.
//

import Foundation
import UIKit

extension UIView {
    
    func setLayout(WithBorderWidth borderWidth: CGFloat,
                   borderColor: UIColor?,
                   radius aRadius: CGFloat,
                   andBackgroundColor bgColor: UIColor?) {
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = aRadius
        if(borderColor != nil) {
            self.layer.borderColor = borderColor?.cgColor
        }
        if(bgColor != nil) {
            self.layer.backgroundColor = bgColor?.cgColor
        }
    }    
}
