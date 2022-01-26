//
//  UIViewController+.swift
//  TaskerList
//
//  Created by Ilya on 26.01.2022.
//

import UIKit

extension UIViewController {
    func presentAlert(message : String,
                      withTitle title: String = "",
                      completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            completion?()
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
