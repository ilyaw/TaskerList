//
//  String+.swift
//  TaskerList
//
//  Created by Ilya on 26.01.2022.
//

import Foundation

extension String {
    
    enum ValidTypes {
        case name
        case email
        case phone
        case price
    }
    
    enum Regex: String {
        case name = "^[a-zA-Zа-яА-Я]+(([',. -][a-zA-Zа-яА-Я ])?[a-zA-Zа-яА-Я]*)*$"
        case email = "[a-zA-Z0-9._-]+@[a-zA-Z]+\\.[a-zA-Z]{2,}"
        case phone = "\\+\\d\\s\\(\\d{3}\\)\\s\\d{3}-\\d{2}-\\d{2}"
        case price = "\\d{1,19}"
    }
    
    func isValid(validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        case .name: regex = Regex.name.rawValue
        case .email: regex = Regex.email.rawValue
        case .phone: regex = Regex.phone.rawValue
        case .price: regex = Regex.price.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
