//
//  ViewController.swift
//  chem-mvp
//
//  Created by macos on 7/3/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit

class LabBenchViewController: UIViewController {

    var reagents : [Reagent] = []
    var reagentsInSpawn : [Reagent] = []
    
    @IBOutlet var labBenchView: LabBenchView!
    
    override func viewWillAppear(_ animated: Bool) {
        let benchWidth = labBenchView.frame.size.width
        let benchHeight = labBenchView.frame.size.height
        
        
        
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

