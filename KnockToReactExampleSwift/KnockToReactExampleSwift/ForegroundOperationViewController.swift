//
//  ForegroundOperationViewController.swift
//  KnockToReactExampleSwift
//
//  Created by Matheus Cavalca on 3/25/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class ForegroundOperationViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet var viewContent: UIView!
    @IBOutlet var knocksCounter: UILabel!
    
    var circleView: UIView!
    
    let knockManager = KnockToReact.sharedInstance
    var singleKnocks: Int! {
        didSet {
            knocksCounter.text = singleKnocks.description + "/" + knockManager.numberOfKnocksNeeded.description
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCircleView()
        singleKnocks = 0
        
        knockManager.delegate = self
        knockManager.startOperation()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animateCircleView()
    }
    
    // MARK: - Configuration
    
    func configureCircleView() {
        circleView = UIView()
        circleView.backgroundColor = UIColor(red: 6.0/255.0, green: 107.0/255.0, blue: 151.0/255.0, alpha: 1.0)
        circleView.alpha = 0.0
        circleView.frame = CGRectMake(0, 0, 150, 150)
        circleView.center = self.view.center
        circleView.layer.cornerRadius = 75
        
        view.addSubview(circleView)
        view.sendSubviewToBack(circleView)
    }
    
    // MARK: - Animation
    
    func animateCircleView() {
        UIView.animateWithDuration(0.5, delay: 0.0, options: [.Autoreverse, .Repeat], animations: {
            self.circleView.alpha = 0.5
            self.circleView.transform = CGAffineTransformMakeScale(1.5, 1.5)
        }, completion: nil)
    }
    
    // MARK: - Action
    
    @IBAction func `return`(sender: AnyObject) {
        self.circleView.layer.removeAllAnimations()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension ForegroundOperationViewController: KnockToReactDelegate {
    
    func singleKnockPerformed() {
        singleKnocks = singleKnocks + 1
        self.circleView.layer.removeAllAnimations()
        UIView.animateWithDuration(0.5, delay: 0.0, options: [.CurveLinear], animations: {
            self.circleView.alpha = 0.5
            self.circleView.transform = CGAffineTransformMakeScale(6.0, 6.0)
        }, completion: { (Bool) in
            self.circleView.frame = self.view.frame
            self.circleView.layer.cornerRadius = 0
            self.configureCircleView()
            self.animateCircleView()
        })
    }
    
    func knockEventPerformed() {
        
    }
    
}
