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
    //var classQueue = dispatch_queue_create("by.andrewjohnsson.drawer.classes", DISPATCH_QUEUE_CONCURRENT)
    //var pointQueue = dispatch_queue_create("by.andrewjohnsson.drawer.points", DISPATCH_QUEUE_CONCURRENT)
    
    func drawPoints(entity: [ClassPoint]){
        for cl in 0...entity.count-1
        {
            var drawerQueue = dispatch_queue_create("by.andrewjohnsson.drawer", DISPATCH_QUEUE_CONCURRENT)
            dispatch_barrier_async(drawerQueue, {
                dispatch_sync(dispatch_get_main_queue(), {
                    let classDot = CAShapeLayer()
                    let path = UIBezierPath.init(ovalInRect: CGRectMake(0.0, 0.0, 2.0, 2.0))
                    classDot.path = path.CGPath
                    classDot.strokeColor = entity[cl].getColor()
                    classDot.lineWidth = 2
                    classDot.bounds = CGRectMake(0.0, 0.0, 0.0, 0.0)
                    classDot.position = CGPointMake(entity[cl].coordinate.x, entity[cl].coordinate.y)
                    self.vc.canvas.layer.addSublayer(classDot)
                    
                    for point in 0...entity[cl].points.count-1{
                        let dot = CAShapeLayer()
                        let path = UIBezierPath.init(ovalInRect: CGRectMake(0.0, 0.0, 0.5, 0.5))
                        dot.path = path.CGPath
                        dot.strokeColor = entity[cl].getColor()
                        dot.lineWidth = 0.5
                        dot.bounds = CGRectMake(0.0, 0.0, 0.0, 0.0)
                        dot.position = CGPointMake(entity[cl].points[point].coordinate.x,entity[cl].points[point].coordinate.y)
                        self.vc.canvas.layer.addSublayer(dot)
                    }
                    self.rasterize()
                })
            })
            drawerQueue = nil
        }
    }
    
    func rasterize(){
        self.vc.canvas.layer.shouldRasterize = true
    }
    
    func deleteLayers(){
        self.vc.canvas.layer.sublayers = nil
    }
    
    init(vc: ViewController, controller: Controller){
        self.vc = vc
        self.controller = controller
    }
}
