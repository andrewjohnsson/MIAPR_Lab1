//
//  ViewController.swift
//  recognizer
//
//  Created by Andrew Johnsson on 02.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate{
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var canvas: UIImageView!
    @IBOutlet weak var pointsNumber: UITextField!
    @IBOutlet weak var classesNumber: UITextField!
    @IBOutlet weak var generateBtn: UIBarButtonItem!
    
    @IBAction func clear(sender: AnyObject) {
        view.endEditing(true)
        pointsNumber.text = ""
        classesNumber.text = ""
        canvas.image = nil
    }
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func generate(sender: AnyObject) {
        view.endEditing(true)
        guard let amount:(Int,Int) = (Int(classesNumber.text!)!, Int(pointsNumber.text!)!) else{
            return
        }
        let generator = Controller(vc: self)
        generator.initDrawer(self)
        generator.process(amount)
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

