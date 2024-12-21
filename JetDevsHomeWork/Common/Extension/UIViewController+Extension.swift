//
//  UIViewController+Extension.swift
//  JetDevsHomeWork
//
//    21/12/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboardOntouch))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboardOntouch() {
        view.endEditing(true)
    }
}
