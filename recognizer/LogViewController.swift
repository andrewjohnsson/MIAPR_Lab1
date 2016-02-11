//
//  LogViewController.swift
//  recognizer
//
//  Created by Andrew Johnsson on 04.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import Foundation
import UIKit

class LogViewController: UIViewController, LoggerDelegate{
    @IBOutlet weak var pointsLog: UITextView!
    
    func logPoint(x:CGFloat, y: CGFloat){
        pointsLog.text.appendContentsOf("\n" + String(NSDate()) + "    Point(" + String(x) + ", " + String(y) + ")")
    }
    
    @IBAction func setDelegate(segue: UIStoryboardSegue){
        //let vc = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-2] as! ViewController
        NSLog("done!")
        let vc = segue.sourceViewController as! ViewController
        vc.delegate = self
        pointsLog.text.appendContentsOf("Source is: " + vc.debugDescription)
    }
    
    @IBAction func clear(sender: AnyObject) {
        pointsLog.text! = ""
    }
    
    override func viewDidLoad() {
        let vc = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-2] as! ViewController
        vc.delegate = self
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}