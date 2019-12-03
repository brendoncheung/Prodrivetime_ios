//
//  FilterPredicates.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/22/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

class FilterPredicate {
    
    static func byDate() -> (Int, Int) -> (Bool) {
    
        let pred: (Int, Int) -> Bool = { (old: Int, new: Int) in
            return old < new
        }
        return pred
    }
    
    static func byName() -> (String, String) -> Bool {
        
        let pred: (String, String) -> Bool = { new, target in
            return new == target
        }
        return pred
        
    }
    
    
    
    
}

