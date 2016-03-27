//
//  ConfigurationViewController.swift
//  KnockToReactExampleSwift
//
//  Created by Lucas Farah on 3/22/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class ConfigurationViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet var nKnocksLabel: UILabel!
    
    let knockManager = KnockToReact.sharedInstance
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action
    
    @IBAction func nKnocksStepperValueChanged(sender: AnyObject) {
        let numberOfKnocks = Int((sender as! UIStepper).value)
        nKnocksLabel.text = numberOfKnocks.description
        
        knockManager.numberOfKnocksNeeded = numberOfKnocks
    }
    
    
}