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
    
    var generatorQueue = dispatch_queue_create("by.andrewjohnsson.generator", DISPATCH_QUEUE_CONCURRENT)
    
    func initDrawer(vc: ViewController){
        self.drawer = Drawer(vc: vc, controller: self)
    }
    
    func generate(amount: (Int,Int)){
        self.drawer!.deleteLayers()
        self.process(amount)
        self.drawer!.drawPoints(classesEntity)
        //self.drawer!.rasterize()
    }
    
    func addClass(cl: ClassPoint) -> ClassPoint{
        self.classesEntity.append(cl)
        return cl
    }
    
    func setClass(point: Point){
        var distance = CGFloat.max
        var bestClass: ClassPoint?
        for cl in 0...classesEntity.count-1{
            let curDist: CGFloat = hypot(point.coordinate.x - classesEntity[cl].coordinate.x,
                                        point.coordinate.y - classesEntity[cl].coordinate.y)
            if (curDist < distance){
                bestClass = classesEntity[cl]
                distance = curDist
            }
        }
        bestClass?.points.append(point)
        point.setClass(bestClass!)
    }
    
    func process(amount: (Int,Int)){
        for _ in 0...amount.0-1{
            dispatch_barrier_async(self.generatorQueue, {
                self.addClass(ClassPoint())
            })
        }
        for _ in 0...amount.1-1{
            dispatch_barrier_async(self.generatorQueue, {
                self.setClass(Point())
            })
        }
    }
    
    deinit{
        self.classesEntity = []
    }
}
