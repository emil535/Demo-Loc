//
//  ChartDetailTVC.swift
//  Demo-Loc
//
//  Created by Emil Safier on 9/4/20.
//  Copyright © 2020 Emil Safier. All rights reserved.
//

import UIKit

class ChartDetailTVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title =  "Localization Demo"
        navigationItem.prompt = "Version 1.2"
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueID =  segue.identifier
        print("segueID: \(segueID)")
        switch segueID {
        case "redID":
            let targetVC = segue.destination as? RedVC
            targetVC?.title =  NSLocalizedString( "Red",
                                                  comment: "The color red")
        case "blueID":
            print("segueID:  \(segueID)")
            let targetVC = segue.destination as? BlueVC
            targetVC?.title = NSLocalizedString("navBarTitle.blue",
                                                value: "Blue",
                                                comment: "The color blue")
            //"Blue "
        //  NSLocalizedString(<#T##key: String##String#>, comment: <#T##String#>)
        case "greenID":
            print("segueID:  \(segueID)")
            let targetVC = segue.destination as? GreenVC
            targetVC?.title = NSLocalizedString("navBarTitle.green",
                                                value: "Green",
                                                comment: "")
        default:
            break
        }
    }
    
}
