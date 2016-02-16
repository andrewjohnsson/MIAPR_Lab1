//
//  Controller.swift
//  recognizer
//
//  Created by Andrew Johnsson on 13.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import UIKit

class Controller{
    var drawer: Drawer?
    var classesEntity: [ClassPoint] = []
    
    var generatorQueue = dispatch_queue_create("by.andrewjohnsson.generator.classes", DISPATCH_QUEUE_CONCURRENT)
    var pointsQueue = dispatch_queue_create("by.andrewjohnsson.generator.points", DISPATCH_QUEUE_CONCURRENT)
    
    func initDrawer(vc: ViewController){
        self.drawer = Drawer(vc: vc, controller: self)
    }
    
    func generate(amount: (Int,Int)){
        self.process(amount)
        self.cleanup()
    }
    
    func addClass(cl: ClassPoint) -> ClassPoint{
        self.classesEntity.append(cl)
        return cl
    }
    
    func setClass(point: Point){
        var distance = CGFloat.max
        var bestClass: ClassPoint?
        for cl in 0...classesEntity.count-1{
            let curDist: CGFloat = hypot(CGFloat(point.coordinate.x) - CGFloat(classesEntity[cl].coordinate.x),
                                        CGFloat(point.coordinate.y) - CGFloat(classesEntity[cl].coordinate.y))
            if (curDist < distance){
                bestClass = classesEntity[cl]
                distance = curDist
            }
        }
        bestClass?.points.append(point)
    }
    
    func process(amount: (Int,Int)){
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            dispatch_barrier_sync(self.generatorQueue, {
                for _ in 0...amount.0-1{
                    self.addClass(ClassPoint())
                }
                for _ in 0...amount.1-1{
                    self.setClass(Point())
                }
            })
            dispatch_async(dispatch_get_main_queue(), {
                self.drawer!.drawPoints(self.classesEntity)
            })
        })
    }
    
    func cleanup(){
        self.classesEntity = []
        self.drawer = nil
    }
    
    deinit{
        self.classesEntity = []
    }
}
