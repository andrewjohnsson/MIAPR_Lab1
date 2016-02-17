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
    
    func initDrawer(vc: ViewController){
        self.drawer = Drawer(vc: vc, controller: self)
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
            for _ in 0...amount.0-1{
                self.addClass(ClassPoint())
            }
            for _ in 0...amount.1-1{
                self.setClass(Point())
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.drawer!.drawPoints(self.classesEntity)
            })
        })
    }
    
    deinit{
        self.classesEntity = []
    }
}
