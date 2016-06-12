//
//  ConfigurationViewController.swift
//  KnockToReactExampleSwift
//
//  Created by Lucas Farah on 3/22/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import Knock

class ConfigurationViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet var nKnocksLabel: UILabel!
    
    let knockManager = Knock.sharedInstance
    
    @IBOutlet var btwnKnockOperationsLabel: UILabel!
    @IBOutlet var minBtwnSingleKnocksLabel: UILabel!
    @IBOutlet var maxBtwnSingleKnocks: UILabel!
    
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
    
    @IBAction func sensibilityValueChanged(sender: AnyObject) {
        knockManager.limitDifference = Double((sender as! UISlider).value)
    }
    
    @IBAction func btwnKnockOperationStepperValueChanged(sender: AnyObject) {
        let timeBetweenKnockOperations = Double((sender as! UIStepper).value)
        btwnKnockOperationsLabel.text = timeBetweenKnockOperations.description
        knockManager.timeNeededBetweenKnockOperations = timeBetweenKnockOperations
    }
    
    @IBAction func minBtwnSingleKnocksStepperValueChanged(sender: AnyObject) {
        let minBetweenSingleKnock = Double((sender as! UIStepper).value)
        minBtwnSingleKnocksLabel.text = minBetweenSingleKnock.description
        knockManager.minimumTimeBetweenSingleKnocks = minBetweenSingleKnock
    }
    
    @IBAction func maxBtwnSingleKnocksStepperValueChanged(sender: AnyObject) {
        let maxBetweenSingleKnock = Double((sender as! UIStepper).value)
        maxBtwnSingleKnocks.text = maxBetweenSingleKnock.description
        knockManager.maximumTimeBetweenSingleKnocks = maxBetweenSingleKnock
    }
    
}