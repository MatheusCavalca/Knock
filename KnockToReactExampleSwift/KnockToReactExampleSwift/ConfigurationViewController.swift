//
//  ConfigurationViewController.swift
//  KnockToReactExampleSwift
//
//  Created by Lucas Farah on 3/22/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class ConfigurationViewController: UITableViewController, KnockToReactDelegate {

    let knockManager = KnockToReact.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        knockManager.delegate = self
        knockManager.startOperation()
    }

    func knockEventPerformed() {
        print("knock")
    }

}