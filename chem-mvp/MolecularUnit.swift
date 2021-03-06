//
//  MolecularUnit.swift
//  chem-mvp
//
//  Created by macos on 7/3/18.
//  Copyright © 2018 mc. All rights reserved.
//

import Foundation
import UIKit

class MolecularUnit : Equatable {
    
    enum Atom : String {
        case Ag = "Ag"
        case N = "N"
        case O = "O"
        case Ba = "Ba"
        case Cl = "Cl"
        case H = "H"
        case Li = "Li"
        case Mn = "Mn"
        case S = "S"
        case K = "K"
        case C = "C"
        case Br = "Br"
        case Na = "Na"
        case Pb = "Pb"
        case Hg = "Hg"
        case I = "I"
        case P = "P"
        case As = "As"
        case B = "B"
        case Rb = "Rb"
        case Cs = "Cs"
        case Fr = "Fr"
    }
    
    var charge : Int
    var subscripts : [Int] = []
    var atoms : [Atom] = []
    var suFont : UIFont
    var attributedFormula = NSMutableAttributedString()
    var formula = String()
    
    init(atoms: [Atom], charge: Int, subscripts: [Int]) {
        self.atoms = atoms
        self.charge = charge
        self.subscripts = subscripts
        self.suFont = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 10)
        print("unit initialized")
    }
    
    init(atoms: String, charge: Int, subscripts: String) {
        let atomized = atoms.components(separatedBy: ",")
        let subscripted = subscripts.components(separatedBy: ",")
        
        for atom in atomized {
            self.atoms.append(Atom.init(rawValue: atom)!)
        }
        
        for script in subscripted {
            self.subscripts.append(Int(script)!)
        }
        self.charge = charge
        self.suFont = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 10)
        self.attributedFormula = NSMutableAttributedString(string: "")
        print("unit initialized")
    }
    
    func toString() -> String {
        formula = String()
        for i in 0...atoms.count-1 {
            formula.append(atoms[i].rawValue)
            if subscripts[i] > 1 {
                formula.append(String(subscripts[i]))
            }
        }
        return formula
    }
    
    func toAttributedString() -> NSMutableAttributedString {
        attributedFormula = NSMutableAttributedString()
        for i in 0...atoms.count-1 {
            var attString : NSMutableAttributedString
            if subscripts[i] > 1 {
                let subscriptLength : Int = getIntLength(integer: subscripts[i])
                let atom = atoms[i].rawValue + String(subscripts[i])
                attString = NSMutableAttributedString(string: atom)
                attString.setAttributes([.font:suFont,.baselineOffset:-2], range: NSRange(location: atom.count - subscriptLength, length: subscriptLength))
            }
            else {
                attString = NSMutableAttributedString(string: atoms[i].rawValue)
            }
            attributedFormula.append(attString)
        }
        //TODO: add superscripts?
        return attributedFormula
    }
    
    func getIntLength(integer: Int) -> Int {
        //None of our subscripts or superscripts will exceed double-digits
        if integer > 10 {
            return 2
        }
        else {
            return 1
        }
    }
    
    static func == (lhs: MolecularUnit, rhs: MolecularUnit) -> Bool {
        if lhs.atoms == rhs.atoms {
            return true
        }
        return false
    }
}
