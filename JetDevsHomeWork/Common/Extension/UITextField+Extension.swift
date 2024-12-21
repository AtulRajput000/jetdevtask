//
//  UITextField+Extension.swift
//  JetDevsHomeWork
//
//    21/12/24.
//

import Foundation
import UIKit

extension UITextField {
    
    func setLeftPaddingInTextField(_ leftPadding: CGFloat) {
        let lLeftPaddingView = UIView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: leftPadding,
                                                    height: self.frame.size.height))
        self.leftView = lLeftPaddingView
        self.leftViewMode = UITextField.ViewMode.always
    }
}
