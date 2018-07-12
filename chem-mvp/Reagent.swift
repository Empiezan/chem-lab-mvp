//
//  Reagent.swift
//  chem-mvp
//
//  Created by macos on 7/3/18.
//  Copyright © 2018 mc. All rights reserved.
//

import Foundation
import UIKit

class Reagent : Equatable {
    
    var components : [MolecularUnit] = []
    var formula = NSMutableAttributedString(string: "")
    var molarity : Float = 0.1
    var volume : Float = 50
    var container : Glassware!
    var subscripts : [Int]!
    
    init(components: [MolecularUnit], subscripts: String) {
        self.components = components
        
        var scripted : [Int] = []
        for sub in subscripts.split(separator: ",") {
            scripted.append(Int(sub)!)
        }
        
        self.subscripts = scripted
    }
    
    init(components: [MolecularUnit], superscripts: [Int]) {
        self.components = components
        self.subscripts = superscripts
    }
    
    func toString() -> NSMutableAttributedString {
        formula = NSMutableAttributedString(string: "")
        for i in 0...components.count-1 {
            formula.append(components[i].toString())
        }
        return formula
    }
    
    static func == (lhs: Reagent, rhs: Reagent) -> Bool {
        if lhs.components == rhs.components {
            if lhs.formula == rhs.formula {
                return true
            }
        }
        return false
    }
    
//    func addSubscript(munit: String, subscript: Int) -> NSMutableAttributedString {
//        let subFont:UIFont = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 10)
//        let attString = NSMutableAttributedString(string: munit, attributes: [.font:UIFont()])
//
//        attString.setAttributes([.font:subFont,.baselineOffset:-5], range: NSRange(location: 8, length: 2))
//
//            return attString
//    }
}
