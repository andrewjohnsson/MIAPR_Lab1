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
    
    func drawPoints(entity: [ClassPoint]){
        UIGraphicsBeginImageContext(self.vc.canvas.bounds.size)
        let context = UIGraphicsGetCurrentContext()
        self.vc.canvas.image?.drawInRect(CGRectMake(self.vc.canvas.frame.origin.x, self.vc.canvas.frame.origin.y, self.vc.canvas.frame.width, self.vc.canvas.frame.height))
        for cl in 0...entity.count-1
        {
            CGContextSetFillColorWithColor(context, entity[cl].getColor())
            CGContextFillEllipseInRect(context,
                CGRectMake(CGFloat(entity[cl].coordinate.x),
                CGFloat(entity[cl].coordinate.y),
            5, 5))
            for point in 0...entity[cl].points.count-1{
                let context = UIGraphicsGetCurrentContext()
                CGContextSetFillColorWithColor(context, entity[cl].getColor())
                CGContextFillEllipseInRect(context, CGRectMake(
                    CGFloat(entity[cl].points[point].coordinate.x),
                    CGFloat(entity[cl].points[point].coordinate.y),
                    2, 2))
            }
        }
        self.vc.canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    init(vc: ViewController, controller: Controller){
        self.vc = vc
        self.controller = controller
    }
}
