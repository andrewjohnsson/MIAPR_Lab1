//
//  LogViewController.swift
//  recognizer
//
//  Created by Andrew Johnsson on 04.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import Foundation
import UIKit

class LogViewController: UIViewController{
    @IBOutlet weak var pointsLog: UITextView!

    @IBAction func clear(sender: AnyObject) {
        pointsLog.text! = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}