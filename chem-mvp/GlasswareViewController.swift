//
//  GlasswareViewController.swift
//  chem-mvp
//
//  Created by macos on 7/2/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class GlasswareViewController: UIViewController, UITableViewDataSource {
    
    var glassware : [String] = []
    
    @IBOutlet weak var glassTable: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return glassware.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = glassTable.dequeueReusableCell(withIdentifier: "glassware")
        cell?.textLabel?.text = glassware[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("clicked on \(glassware[indexPath.row])")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        glassware.removeAll()
        glassTable.dataSource = self
        // Do any additional setup after loading the view.
        let ref = Database.database().reference()
        ref.observe(.value, with: {
            snapshot in
            let data = snapshot.value as! NSDictionary
            let glassData = data["Glassware"] as! NSDictionary
            
            for (name, _) in glassData {
                self.glassware.append(name as! String)
                print(name as! String)
            }
            self.glassTable.reloadData()
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
