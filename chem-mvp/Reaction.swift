//
//  Reaction.swift
//  chem-mvp
//
//  Created by macos on 7/4/18.
//  Copyright © 2018 mc. All rights reserved.
//

import Foundation

class Reaction {
    var reactants : [MolecularUnit] = []
    var rCoefficients : [Int] = []
    var products : [Reagent] = []
    var pCoefficients : [Int] = []
    
    var alkali : [String] = ["H", "Li", "Na", "K", "Rb", "Cs", "Fr"]
    
    let hydrogen = MolecularUnit(atoms: [.H], charge: 1, subscripts: [1])
    let lithium = MolecularUnit(atoms: [.Li], charge: 1, subscripts: [1])
    
    
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
    
    var knownPrecAnions : [MolecularUnit] = []
    
    var cations : [MolecularUnit] = []
    var anions : [MolecularUnit] = []
    
    init(reactants: [Reagent]) {
        for reactant in reactants {
            for molecularUnit in reactant.components {
                self.reactants.append(molecularUnit)
            }
        }
        self.knownPrecAnions = [chloride, bromide, iodide, sulfate, carbonate, phosphate, sulfite, sulfide, borate, arsenate]
    }
    
    func getRxn() {
        //MnSO4 + K2CO3 -> MnCO3 + SO4 + 2K
        //result aray = reactants[0] split into two and split reactants[1] into two
        let reactantUnits : [MolecularUnit] = []
        
        for reactant in reactantUnits {
            if reactant.charge < 0 {
                anions.append(reactant)
            }
            else {
                cations.append(reactant)
            }
        }
        
        let nonAlkali = getNonAlkali()
        let precipitableAnions = getPreciptableAnions()
        
        var nonSpectators : [MolecularUnit] = []
        
        for metal in nonAlkali {
            if metal.atoms[0] == .Ba {
                if precipitableAnions.contains(sulfate) {
                    products.append(Reagent(components: [barium, sulfate], superscripts: [2,1]))
                    nonSpectators.append(barium) 
                    nonSpectators.append(sulfate)
                }
            }
            else {
                for anion in precipitableAnions {
                    for metal in nonAlkali {
                        products.append(Reagent(components: [metal, anion], superscripts: []))
                        nonSpectators.append(metal)
                        nonSpectators.append(anion)
                    }
                }
            }
        }
        
        for reactant in reactants {
            if !nonSpectators.contains(reactant) {
                products.append(Reagent(components: [reactant], superscripts: [1]))
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
        
        for reactant in reactants {
            print(reactant.toString())
        }
        
    }
    
    func getPreciptableAnions() -> [MolecularUnit] {
        var precip : [MolecularUnit] = []
        
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
    
    func getNonAlkali() -> [MolecularUnit] {
        //TODO: implement more efficient version with hashset
        var nonAlkali : [MolecularUnit] = []
        
//        if reactants.contains(manganese) { nonAlkali.append(manganese) }
//        if reactants.contains(lead) { nonAlkali.append(lead) }
//        if reactants.contains(silver) { nonAlkali.append(silver) }
//        if reactants.contains(mercury) { nonAlkali.append(mercury) }
//        if reactants.contains(barium) { nonAlkali.append(barium) }

        for cation in cations {
            if alkali.contains(cation.atoms[0].rawValue) {
                nonAlkali.append(cation)
            }
        }
        
        return nonAlkali
    }
    
}
