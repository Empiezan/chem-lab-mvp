//
//  Reaction.swift
//  chem-mvp
//
//  Created by macos on 7/4/18.
//  Copyright © 2018 mc. All rights reserved.
//

import Foundation

class Reaction {
    var reactants : [Reagent] = []
    var rCoefficients : [Int] = []
    var products : [Reagent] = []
    var pCoefficients : [Int] = []
    
    
    var alkali : [String] = ["H", "Li", "Na", "K", "Rb", "Cs", "Fr"]
    
    let barium = MolecularUnit(atoms: [.Ba], charge: 2, subscripts: [1])
    let manganese = MolecularUnit(atoms: [.Mn], charge: 2, subscripts: [1])
    let lead = MolecularUnit(atoms: [.Pb], charge: 1, subscripts: [1])
    let silver = MolecularUnit(atoms: [.Ag], charge: 1, subscripts: [1])
    let mercury = MolecularUnit(atoms: [.Hg], charge: 1, subscripts: [1])
    
    let chloride = MolecularUnit(atoms: [.Cl], charge: -1, subscripts: [1])
    let bromide = MolecularUnit(atoms: [.Br], charge: -1, subscripts: [1])
    let iodide = MolecularUnit(atoms: [.I], charge: -1, subscripts: [1])
    let sulfate = MolecularUnit(atoms: [.S, .O], charge: -2, subscripts: [1,4])
    let carbonate = MolecularUnit(atoms: [.C, .O], charge: -2, subscripts: [1,3])
    let phosphate = MolecularUnit(atoms: [.P, .O], charge: -3, subscripts: [1,4])
    let sulfite = MolecularUnit(atoms: [.S, .O], charge: -2, subscripts: [1,3])
    let sulfide = MolecularUnit(atoms: [.S], charge: -2, subscripts: [1])
    let borate = MolecularUnit(atoms: [.B, .O], charge: -3, subscripts: [1,3])
    let arsenate = MolecularUnit(atoms: [.As, .O], charge: -3, subscripts: [1,4])
    
    var knownPrecAnions : [Reagent] = []
    
    var cations : [Reagent] = []
    var anions : [Reagent] = []
    
    init(reactants: [Reagent]) {
        self.reactants = reactants
        self.knownPrecAnions = [chloride, bromide, iodide, sulfate, carbonate, phosphate, sulfite, sulfide, borate, arsenate]
    }
    
    func getRxn() {
        //MnSO4 + K2CO3 -> MnCO3 + SO4 + 2K
        //result aray = reactants[0] split into two and split reactants[1] into two
        var arr : [Reagent] = []
        for reactant in reactants {
            for molecularUnit in reactant.components {
                arr.append(Reagent(components: [molecularUnit]))
            }
        }
        reactants = arr
        
        for reactant in reactants {
            if reactant.components[0].charge < 0 {
                anions.append(reactant)
            }
            else {
                cations.append(reactant)
            }
        }
        
        let nonAlkali = getNonAlkali()
        let precipitableAnions = getPreciptableAnions()
        
        print("\(nonAlkali.count) non-alkali metals")
        print("\(precipitableAnions.count) precipitable anions")
        
        var nonSpectators : [Reagent] = []
        
        for metal in nonAlkali {
            if metal.components[0].atoms[0] == .Ba {
                if precipitableAnions.contains(sulfate) {
                    products.append(Reagent(components: barium.components + sulfate.components))
                    nonSpectators.append(barium)
                    nonSpectators.append(sulfate)
                }
            }
            else {
                for anion in precipitableAnions {
                    if anion == sulfate && (metal == barium || metal == silver || (metal == lead)){
                        products.append(Reagent(components: metal.components + anion.components))
                        nonSpectators.append(metal)
                        nonSpectators.append(anion)
                    }
                    else if (anion == chloride || anion == bromide || anion == iodide) && (metal == silver || metal == lead || metal == mercury){
                        products.append(Reagent(components: metal.components + anion.components))
                        nonSpectators.append(metal)
                        nonSpectators.append(anion)
                    }
                    else if anion == carbonate || anion == phosphate || anion == borate || anion == arsenate {
                        products.append(Reagent(components: metal.components + anion.components))
                        nonSpectators.append(metal)
                        nonSpectators.append(anion)
                    }
                }
            }
        }
        
        for reactant in reactants {
            if !nonSpectators.contains(reactant) {
                print("appending spectator")
                products.append(reactant)
            }
        }
        
        //Matrix Algebra...
        
 
//        if anions.contains(carbonate) && cations.contains(manganese) {
//            let ci = reactants.index(of: carbonate)
//            reactants.remove(at: ci!)
//            let mi = reactants.index(of: manganese)
//            reactants.remove(at: mi!)
//            reactants.append(Reagent(components: manganese.components + carbonate.components))
//        }
        
//        for reactant in reactants {
//            print(reactant.toString())
//        }
        
    }
    
    func getPreciptableAnions() -> [Reagent] {
        var precip : [Reagent] = []
        
//        if reactants.contains(chloride) { precip.append(chloride) }
//        if reactants.contains(bromide) { precip.append(bromide) }
//        if reactants.contains(iodide) { precip.append(iodide) }
//        if reactants.contains(sulfate) { precip.append(sulfate) }
//        if reactants.contains(carbonate) { precip.append(carbonate) }
//        if reactants.contains(phosphate) { precip.append(phosphate) }
//        if reactants.contains(sulfite) { precip.append(sulfite) }
//        if reactants.contains(sulfide) { precip.append(sulfide) }
//        if reactants.contains(borate) { precip.append(borate) }
//        if reactants.contains(arsenate) { precip.append(arsenate) }

        for anion in knownPrecAnions {
            if reactants.contains(anion) {
                precip.append(anion)
            }
        }
        
        return precip
    }
    
    func getNonAlkali() -> [Reagent] {
        //TODO: implement more efficient version with hashset
        var nonAlkali : [Reagent] = []
        
//        if reactants.contains(manganese) { nonAlkali.append(manganese) }
//        if reactants.contains(lead) { nonAlkali.append(lead) }
//        if reactants.contains(silver) { nonAlkali.append(silver) }
//        if reactants.contains(mercury) { nonAlkali.append(mercury) }
//        if reactants.contains(barium) { nonAlkali.append(barium) }

        for cation in cations {
            if !alkali.contains(cation.components[0].atoms[0].rawValue) {
                nonAlkali.append(cation)
            }
        }
        
        return nonAlkali
    }
    
    func toString() -> NSAttributedString {
        let equation : NSMutableAttributedString = NSMutableAttributedString(string: "")
        for reactant in reactants {
             equation.append(reactant.toString())
            if reactant != reactants.last {
                equation.append(NSAttributedString(string: "+"))
            }
        }
        equation.append(NSAttributedString(string: "->"))
        for product in products {
            equation.append(product.toString())
            if product != products.last {
                equation.append(NSAttributedString(string: "+"))
            }
        }
        return equation
    }
    
}
