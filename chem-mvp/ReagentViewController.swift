//
//  ReagentViewController.swift
//  chem-mvp
//
//  Created by macos on 7/2/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ReagentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var reagents : [Reagent] = []
    
    @IBOutlet weak var reagentTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let ref = Database.database().reference()
        ref.observe(.value, with: {
            snapshot in
            let data = snapshot.value as! NSDictionary
            let reagentsData = data["Reagents"] as! NSDictionary
            
            for (_, formula) in reagentsData {
                var components : [MolecularUnit] = []
                var subscripts : String!
                for (propertyName, property) in (formula as! NSDictionary) {
                    print(propertyName as! String)
                    if propertyName as! String == "subscripts" {
                        subscripts = property as! String
                        print(subscripts!)
                    }
                    else {
                        let molecularDict = property as! NSDictionary
                        let atoms = molecularDict["atoms"] as! String
                        print(atoms)
                        let charge = molecularDict["charge"] as! Int
                        print(charge)
                        let subscripts = molecularDict["subscripts"] as! String
                        print(subscripts)
                        components.append(MolecularUnit(atoms: atoms, charge: charge, subscripts: subscripts))
                    }
                    }
                self.reagents.append(Reagent(components: components, subscripts: subscripts))
            }
            self.reagentTable.reloadData()        
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reagents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reagentTable.dequeueReusableCell(withIdentifier: "reagent")
        cell?.textLabel?.attributedText = reagents[indexPath.row].toAttributedString()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reagent = reagents[indexPath.row]
        //Alert user that reagent has been added to lab bench
        let alert = UIAlertController(title: "Lab Bench Updated", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        let reagentString = NSMutableAttributedString(attributedString: reagent.toAttributedString())
        let addedToLabBench = NSMutableAttributedString(string: " added to lab bench")
        reagentString.append(addedToLabBench)
        alert.setValue(reagentString, forKey: "attributedMessage")
        self.present(alert, animated: true)
        
        //TODO: Add reagent to lab bench
        if let bench = parent?.childViewControllers[0] as? LabBenchViewController {
            if !bench.reagentsInSpawn.contains(reagent) {
                bench.reagentsInSpawn.append(reagent)
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }
 

}
