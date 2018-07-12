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
    var attributedFormula = NSMutableAttributedString()
    var formula = String()
    var molarity : Float = 0.1
    var volume : Float = 50
    var container : Glassware!
    var subscripts : [Int]
    var suFont : UIFont
    var beakerView = UIImageView()
    
    init(components: [MolecularUnit], subscripts: String) {
        self.components = components
        
        var scripted : [Int] = []
        for sub in subscripts.split(separator: ",") {
            scripted.append(Int(sub)!)
        }
        
        self.subscripts = scripted
        self.suFont = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 10)
        self.beakerView = UIImageView(image: #imageLiteral(resourceName: "Beaker"))
    }
    
    init(components: [MolecularUnit], superscripts: [Int]) {
        self.components = components
        self.subscripts = superscripts
        self.suFont = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 10)
        self.beakerView = UIImageView(image: #imageLiteral(resourceName: "Beaker"))
    }
    
    func toString() -> String {
        formula = String()
        for i in 0...components.count-1 {
            if subscripts[i] > 1 {
                var subscriptAdded : String
                if components[i].atoms.count > 1 {
                    subscriptAdded = "(\(components[i].toString()))\(subscripts[i])"
                } else {
                    subscriptAdded = "\(components[i].toString())\(subscripts[i])"
                }
                formula.append(subscriptAdded)
            } else {
                formula.append(components[i].toString())
            }
        }
        return formula
    }
    
    func toAttributedString() -> NSAttributedString {
        attributedFormula = NSMutableAttributedString()
        for i in 0...components.count-1 {
            if subscripts[i] > 1 {
                let subscriptLength = getSubscriptLength(integer: i)
                let subscriptAdded = NSMutableAttributedString()
                if components[i].atoms.count > 1 {
                    subscriptAdded.append(NSAttributedString(string: "("))
                    subscriptAdded.append(components[i].toAttributedString())
                    subscriptAdded.append(NSAttributedString(string: ")"))
                } else {
                    subscriptAdded.append(components[i].toAttributedString())
                }
                subscriptAdded.append(NSAttributedString(string: "\(subscripts[i])"))
                subscriptAdded.setAttributes([.font:suFont,.baselineOffset:0], range: NSRange(location: subscriptAdded.length - subscriptLength, length: subscriptLength))
                attributedFormula.append(subscriptAdded)
            } else {
                attributedFormula.append(components[i].toAttributedString())
            }
            
        }
        return attributedFormula
    }
    
    static func == (lhs: Reagent, rhs: Reagent) -> Bool {
        if lhs.components == rhs.components {
            if lhs.attributedFormula == rhs.attributedFormula {
                return true
            }
        }
        return false
    }
    
    func getSubscriptLength(integer: Int) -> Int {
        //None of our subscripts or superscripts will exceed 99
        if integer > 10 {
            return 2
        }
        else {
            return 1
        }
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
