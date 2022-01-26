//
//  UITextField+.swift
//  TaskerList
//
//  Created by Ilya on 26.01.2022.
//

import UIKit

extension UITextField {
    convenience init(borderStyle: UITextField.BorderStyle, cornerRadius: CGFloat = 10) {
        self.init()
        
        self.borderStyle = borderStyle
        layer.cornerRadius = cornerRadius
    }
}
