//
//  String+Extension.swift
//  The Balloon Game
//
//  Created by Akshat Goel on 06/02/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import Foundation
extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func attributedStringWith(_ attributes: [NSAttributedStringKey : Any]? = nil) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
}

extension NSAttributedString {
    
    static func +(left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }
    
    
}

extension Int{
    var degreesToRadians: Double{return Double(self) * .pi/180}
}
