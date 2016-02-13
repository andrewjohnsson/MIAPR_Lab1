//
//  Controller.swift
//  recognizer
//
//  Created by Andrew Johnsson on 13.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import UIKit

class Controller{
    unowned var vc: ViewController
    var drawer: Drawer?
    var pointsEntity: [Point] = []
    var classesEntity: [ClassPoint] = []
    
    func initDrawer(vc: ViewController){
        self.drawer = Drawer(vc: vc, controller: self)
    }
    
    func generateCoord() -> (CGFloat,CGFloat){
        return (CGFloat(arc4random() % UInt32(self.vc.canvas.bounds.size.width)), CGFloat(arc4random() % UInt32(self.vc.canvas.bounds.size.height)))
    }
    
    func generatePoints(points:Int, classes:Int){
        for _ in 0...classes-1{
            let clPoint = ClassPoint(coord: self.generateCoord())
            drawer!.generateColor(clPoint)
            drawer!.drawClass(clPoint)
            classesEntity.append(clPoint)
        }
        
        for _ in 0...points-1{
            let point = Point(coord: self.generateCoord())
            point.setClass(classesEntity)
            drawer!.drawPoint(point)
        }
    }
    
    init(vc: ViewController){
        self.vc = vc
    }
    
    deinit{
        self.pointsEntity = []
        self.classesEntity = []
    }
}
