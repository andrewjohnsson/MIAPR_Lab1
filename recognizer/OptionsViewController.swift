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
    
    func keyboardWillShow(sender: NSNotification){
        if let kbHeight = sender.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue.height{
            self.view.frame.origin.y = self.view.frame.origin.y + kbHeight
            UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseOut, animations: {
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    func keyboardWillHide(sender: NSNotification){
        if let _ = sender.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue.height{
            self.view.frame.origin.y = 0
            UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseOut, animations: {
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
