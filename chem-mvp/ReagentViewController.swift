//
//  ReagentViewController.swift
//  chem-mvp
//
//  Created by macos on 7/2/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ReagentViewController: UIViewController, UITableViewDataSource {
    
    var reagents : [Reagent] = []
    
    @IBOutlet weak var reagentTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reagents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reagentTable.dequeueReusableCell(withIdentifier: "reagent")
        cell?.textLabel?.attributedText = reagents[indexPath.row].toString()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rDVC = self.parent?.parent?.childViewControllers[0] as? ReagentDetailViewController
        rDVC?.reagent = reagents[indexPath.row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reagents.removeAll()
        reagentTable.dataSource = self
        // Do any additional setup after loading the view.
        
        let ref = Database.database().reference()
        ref.observe(.value, with: {
            snapshot in
            let data = snapshot.value as! NSDictionary
            let reagentsData = data["Reagents"] as! NSDictionary
            
            for (_, formula) in reagentsData {
                var components : [MolecularUnit] = []
                for (_, molecularUnit) in (formula as! NSDictionary) {
                    let molecularDict = molecularUnit as! NSDictionary
                    let atoms = molecularDict["atoms"] as? String
                    print(atoms!)
                    let charge = molecularDict["charge"] as? Int
                    print(charge!)
                    let subscripts = molecularDict["subscripts"] as? String
                    print(subscripts!)
                    let superscript = molecularDict["superscript"] as? Int
                    print(superscript!)
                    components.append(MolecularUnit(atoms: atoms!, charge: charge!, subscripts: subscripts!, superscript: superscript!))
                }
                print(components)
                self.reagents.append(Reagent(components: components))
            }
            self.reagentTable.reloadData()
            let rxn : Reaction = Reaction(reactants: [Reagent(components: [MolecularUnit(atoms: "K", charge: 1, subscripts: "2", superscript: 1), MolecularUnit(atoms: "C,O", charge: -2, subscripts: "1,3", superscript: 1)]), Reagent(components: [MolecularUnit(atoms: "Mn", charge: 2, subscripts: "1", superscript: 1), MolecularUnit(atoms: "S,O", charge: -2, subscripts: "1,4", superscript: 1)])])
            rxn.getRxn()
            if let reagentDetailViewController = self.parent?.parent?.childViewControllers[0] as? ReagentDetailViewController {
                reagentDetailViewController.reagentLabel.attributedText = self.reagents[0].toString()
            }
            
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
