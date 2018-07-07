//
//  MolarityPickerView.swift
//  chem-mvp
//
//  Created by macos on 7/6/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit

class MolarityPickerView: UIPickerView {
    
    let molarities = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
