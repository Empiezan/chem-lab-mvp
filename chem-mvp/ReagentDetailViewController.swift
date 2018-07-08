//
//  ReagentDetailViewController.swift
//  chem-mvp
//
//  Created by macos on 7/6/18.
//  Copyright © 2018 mc. All rights reserved.
//
// Credit
// 1. How to do pickerviews
// 2. https://stackoverflow.com/questions/2728152/select-first-row-as-default-in-uitableview

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
            reagentLabel.attributedText = reagent?.toString()
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
    
    @IBAction func addReagentToBench(_ sender: Any) {
        let molarity = molarities[molarityPickerView.selectedRow(inComponent: 0)]
        let volume = volumes[volumePickerView.selectedRow(inComponent: 0)]
        let glass = glassware[glasswarePickerView.selectedRow(inComponent: 0)]
        
//        print("\(volume)mL of \(molarity)M \(reagentLabel.text!) solution in a \(glass)mL beaker")
        
        let labBenchVC = self.parent?.parent?.childViewControllers[0] as? ViewController
        labBenchVC?.reactants.append(reagent!)
        
        let alert = UIAlertController(title: "added to lab bench", message: "\(volume)mL of \(molarity)M \(reagentLabel.text!) solution in a \(glass)mL beaker", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        reagentVC = self.parent?.childViewControllers[0].childViewControllers[0] as? ReagentViewController
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
