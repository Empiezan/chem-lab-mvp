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
    static func == (lhs: MolecularUnit, rhs: MolecularUnit) -> Bool {
        if lhs.atoms == rhs.atoms {
            return true
        }
        return false
    }
    
    
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
    }
    
    var charge : Int
    var subscripts : [Int] = []
    var superscript : Int = 0
    var atoms : [Atom] = []
    var suFont : UIFont
    var formula : NSMutableAttributedString
    
    init(atoms: [Atom], charge: Int, subscripts: [Int], superscript: Int) {
        self.atoms = atoms
        self.charge = charge
        self.subscripts = subscripts
        self.superscript = superscript
        self.suFont = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 10)
        self.formula = NSMutableAttributedString(string: "")
        print("unit initialized")
    }
    
    init(atoms: String, charge: Int, subscripts: String, superscript: Int) {
        let atomized = atoms.components(separatedBy: ",")
        let subscripted = subscripts.components(separatedBy: ",")
        
        for atom in atomized {
            self.atoms.append(Atom.init(rawValue: atom)!)
        }
        
        for script in subscripted {
            self.subscripts.append(Int(script)!)
        }
        self.charge = charge
        self.superscript = superscript
        self.suFont = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 10)
        self.formula = NSMutableAttributedString(string: "")
        print("unit initialized")
    }
    
    func toString() -> NSMutableAttributedString {
        formula = NSMutableAttributedString(string: "")
        for i in 0...atoms.count-1 {
            var attString : NSMutableAttributedString
            if subscripts[i] > 1 {
                let subscriptLength : Int = getIntLength(integer: subscripts[i])
                let atom = atoms[i].rawValue + String(subscripts[i])
                attString = NSMutableAttributedString(string: atom)
                attString.setAttributes([.font:suFont,.baselineOffset:0], range: NSRange(location: atom.count - subscriptLength, length: subscriptLength))
            }
            else {
                attString = NSMutableAttributedString(string: atoms[i].rawValue)
            }
            formula.append(attString)
        }
        //TODO: add superscripts
        return formula
    }
    
    func getIntLength(integer: Int) -> Int {
        //None of our subscripts or superscripts will exceed 99
        if integer > 10 {
            return 2
        }
        else {
            return 1
        }
    }
}
