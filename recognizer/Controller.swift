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
    var classes: [ClassPoint] = []
    var points: [Point] = []
    var vc: ViewController
    
    var queue = dispatch_queue_create("by.andrewjohnsson.processor", DISPATCH_QUEUE_CONCURRENT)
    
    func initDrawer(vc: ViewController){
        self.drawer = Drawer(vc: vc, controller: self)
    }
    
    func addPoint(pt: Point) -> Point{
        self.points.append(pt)
        return pt
    }
    
    func addClass(cl: ClassPoint) -> ClassPoint{
        self.classes.append(cl)
        return cl
    }
    
    func assignClass(points: [Point]){
        for pt in 0...points.count-1{
            var distance = CGFloat.max
            var bestClass: ClassPoint?
            for cl in 0...classes.count-1{
                let curDist = hypot(
                    CGFloat(self.points[pt].coordinate.x) - CGFloat(self.classes[cl].coordinate.x),
                    CGFloat(self.points[pt].coordinate.y) - CGFloat(self.classes[cl].coordinate.y)
                )
                if (curDist < distance){
                    bestClass = self.classes[cl]
                    distance = curDist
                }
            }
            bestClass?.points.append(points[pt])
            points[pt].setClass(bestClass!)
        }
    }
    
    func resignClass(){
        for cl in 0...classes.count-1{
            classes[cl].points = []
        }
    }
    
    func check() -> Bool{
        for cl in 0...classes.count-1{
            if (classes[cl].wasMoved){
                return true
            }
        }
        return false
    }
    
    func normalize(){
        for cl in 0...classes.count-1{
            if ((getMedium(classes[cl]).0 != classes[cl].coordinate.x) &&
                 getMedium(classes[cl]).1 != classes[cl].coordinate.y){
                classes[cl].setCoord(getMedium(classes[cl]))
            }else{
                classes[cl].wasMoved = false
            }
        }
    }
    
    func getMedium(cl: ClassPoint) -> (UInt16, UInt16){
        var midX: Int = 0
        var midY: Int = 0
        for pt in 0...cl.points.count-1{
            midX+=Int(cl.points[pt].coordinate.x)
            midY+=Int(cl.points[pt].coordinate.y)
        }
        return (UInt16(midX/cl.points.count), UInt16(midY/cl.points.count))
    }
    
    func generate(amount: (Int,Int)){
        for _ in 0...amount.0-1{
            self.addClass(ClassPoint())
        }
        for _ in 0...amount.1-1{
            self.addPoint(Point())
        }
    }
    
    func process(amount: (Int,Int)){
        self.vc.indicator.startAnimating()
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            dispatch_barrier_sync(self.queue, {
                self.generate(amount)
                self.assignClass(self.points)
                self.normalize()
                dispatch_barrier_sync(self.queue, {
                    while (self.check()){
                        self.resignClass()
                        self.assignClass(self.points)
                        self.normalize()
                    }
                })
            })
            dispatch_async(dispatch_get_main_queue(), {
                self.vc.progressBar.progress = 0.5
                self.drawer!.drawPoints(self.classes)
                self.vc.progressBar.progress = 1
            })
        })
    }
    
    init(vc: ViewController){
        self.vc = vc
    }
    
    deinit{
        self.classes = []
    }
}
