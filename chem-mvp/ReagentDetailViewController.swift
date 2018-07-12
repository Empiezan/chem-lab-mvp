//
//  ReagentDetailViewController.swift
//  chem-mvp
//
//  Created by macos on 7/6/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit

class ReagentDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let molarities = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
    let volumes = [25, 50, 100, 250, 500]
    let glassware = [50, 100, 250, 500]
    var reagentVC : ReagentViewController!
    
    @IBOutlet weak var reagentLabel: UILabel!
    @IBOutlet weak var molarityPickerView: UIPickerView!
    @IBOutlet weak var volumePickerView: UIPickerView!
    @IBOutlet weak var glasswarePickerView: UIPickerView!
    
    var reagent : Reagent? {
        didSet {
            loadViewIfNeeded()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(pickerView) {
        case molarityPickerView:
            return molarities.count
        case volumePickerView:
            return volumes.count
        case glasswarePickerView:
            return glassware.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(pickerView) {
        case molarityPickerView:
            return "\(molarities[row])M"
        case volumePickerView:
            return "\(volumes[row])mL"
        case glasswarePickerView:
            return "\(glassware[row])mL Beaker"
        default:
            return ""
        }
    }
    
    @IBAction func addReagentToBnech(_ sender: Any) {
        let molarity = molarities[molarityPickerView.selectedRow(inComponent: 0)]
        let volume = volumes[volumePickerView.selectedRow(inComponent: 0)]
        let glass = glassware[glasswarePickerView.selectedRow(inComponent: 0)]
        
        print("\(volume)mL of \(molarity)M \(reagent?.toString()) solution in a \(glass)mL beaker")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reagentVC = self.parent?.childViewControllers[0].childViewControllers[0] as? ReagentViewController
        // Do any additional setup after loading the view.
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
