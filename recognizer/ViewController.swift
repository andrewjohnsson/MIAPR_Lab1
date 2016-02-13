//
//  ViewController.swift
//  recognizer
//
//  Created by Andrew Johnsson on 02.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, GeneratorDelegate{
    @IBOutlet weak var canvas: UIImageView!
    
    weak var delegate: LoggerDelegate?
    
    @IBAction func showOptions(sender: AnyObject) {
        performSegueWithIdentifier("toggleOptions", sender: self)
    }
    
    @IBAction func clear(sender: AnyObject) {
        canvas.layer.sublayers = nil
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toggleOptions"{
            let optionsPopover:OptionsPopoverController = segue.destinationViewController as! OptionsPopoverController
            optionsPopover.modalPresentationStyle = UIModalPresentationStyle.Popover
            optionsPopover.popoverPresentationController!.delegate = self
            optionsPopover.delegate = self
        }
    }
    
    func generate(points: Int, classes: Int) {
        let generator = Controller(vc: self)
        generator.initDrawer(self)
        generator.generatePoints(points, classes: classes)
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

