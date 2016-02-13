//
//  OptionsViewController.swift
//  recognizer
//
//  Created by Andrew Johnsson on 02.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import Foundation
import UIKit

class OptionsPopoverController: UITableViewController{
    
    weak var delegate: GeneratorDelegate?
    
    @IBOutlet weak var pointsNumber: UITextField!
    @IBOutlet weak var classesNumber: UITextField!
    
    @IBAction func drawStart(sender: AnyObject) {
        var pointsAmount = Int(pointsNumber.text!)
        var classAmount = Int(classesNumber.text!)
        
        if (pointsAmount == nil){
            pointsAmount = 1
        }
        if (classAmount == nil){
            classAmount = 1
        }
        
        delegate?.generate(pointsAmount!, classes: classAmount!)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
