//
//  UILabel+.swift
//  TaskerList
//
//  Created by Ilya on 26.01.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont? = .systemFont(ofSize: 20)) {
        self.init()
        
        self.text = text
        self.font = font
    }
}
