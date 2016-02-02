//
//  ViewController.swift
//  recognizer
//
//  Created by Andrew Johnsson on 02.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {    
    @IBAction func showOptions(sender: AnyObject) {
        performSegueWithIdentifier("toggleOptions", sender: self)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toggleOptions"{
            let optionsPopover:OptionsPopoverController = segue.destinationViewController as! OptionsPopoverController
            optionsPopover.modalPresentationStyle = UIModalPresentationStyle.Popover
            optionsPopover.popoverPresentationController!.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

