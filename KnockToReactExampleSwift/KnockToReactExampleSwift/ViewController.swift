//
//  ViewController.swift
//  KnockToReactExampleSwift
//
//  Created by Lucas Farah on 3/22/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class ViewController: UIViewController,KnockHelperProtocol {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let knock = KnockHelper()
    
    knock.delegate = self
    knock.startMotion()
    knock.decrementLimitDifference(10)

  }

  func knockPerformed() {
    print("knock")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

