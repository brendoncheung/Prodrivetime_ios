//
//  StringFormatter.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/4/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

struct StringFormatter {
    
    static func convertStringToCurrency(string: String) -> String {
        
        guard let convertToInteger = Int(string) else { return "-"}
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        let convertToNumber = NSNumber(value: convertToInteger)
        
        guard let string = numberFormatter.string(from: convertToNumber) else { return "-"}
        
        return string
        
    }
    
    
}
