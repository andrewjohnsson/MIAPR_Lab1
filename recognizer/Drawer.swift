//
//  Drawer.swift
//  recognizer
//
//  Created by Andrew Johnsson on 13.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import UIKit

class Drawer{
    let vc: ViewController
    unowned var controller: Controller
    
    func generateColor(cl: ClassPoint){
        let color = UIColor(hue: CGFloat(arc4random() % 256) / 256, saturation: CGFloat(arc4random() % 128) / 256 + 0.5, brightness: CGFloat(arc4random() % 128) / 256 + 0.5, alpha: 1).CGColor
        cl.setColor(color)
    }
    
    func deleteLayers(){
        self.vc.canvas.layer.sublayers = nil
    }
    
    func drawClass(cl: ClassPoint){
        let classDot = CAShapeLayer()
        let path = UIBezierPath.init(ovalInRect: CGRectMake(0.0, 0.0, 2.0, 2.0))
        classDot.path = path.CGPath
        classDot.strokeColor = cl.getColor()
        classDot.lineWidth = 2
        classDot.bounds = CGRectMake(0.0, 0.0, 0.0, 0.0)
        classDot.position = CGPointMake(cl.coordinate.x, cl.coordinate.y)
        self.vc.canvas.layer.addSublayer(classDot)
    }
    
    func drawPoint(var point: Point){
        let dot = CAShapeLayer()
        let path = UIBezierPath.init(ovalInRect: CGRectMake(0.0, 0.0, 0.5, 0.5))
        dot.path = path.CGPath
        dot.strokeColor = point.ownClass?.getColor()
        dot.lineWidth = 0.5
        dot.bounds = CGRectMake(0.0, 0.0, 0.0, 0.0)
        dot.position = CGPointMake(point.coordinate.x,point.coordinate.y)
        self.vc.canvas.layer.addSublayer(dot)
    }
    
    init(vc: ViewController, controller: Controller){
        self.vc = vc
        self.controller = controller
    }
}
