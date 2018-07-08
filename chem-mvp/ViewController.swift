//
//  ViewController.swift
//  chem-mvp
//
//  Created by macos on 7/3/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var reactants : [Reagent] = [] {
        didSet {
            if reactants.count == 1 {
                reactant1.attributedText = reactants[0].toString()
            }
            else if reactants.count > 1 {
                reactant1.attributedText = reactants[0].toString()
                reactant2.attributedText = reactants[1].toString()
            }
            else {
                equation.text = ""
                reactant1.text = ""
                reactant2.text = ""
            }
        }
    }
    var rxn : Reaction!
    
    @IBOutlet weak var reactant1: UILabel!
    @IBOutlet weak var reactant2: UILabel!
    @IBOutlet weak var equation: UILabel!
    
    @IBAction func calculateRxn(_ sender: Any) {
        rxn = Reaction(reactants: [reactants[0], reactants[1]])
        rxn.getRxn()
        equation.attributedText = rxn.toString()
    }
    
    @IBAction func clearEquation(_ sender: Any) {
        reactants.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

