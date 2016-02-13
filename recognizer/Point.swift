//
//  Point.swift
//  recognizer
//
//  Created by Andrew Johnsson on 13.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import UIKit

class Point{
    var coordinate: (x: CGFloat, y: CGFloat)
    weak var ownClass: ClassPoint?
    
    func setClass(entity: [ClassPoint]){
        var distance = CGFloat.max
        for cl in 0...entity.count-1{
            let curDist: CGFloat = hypot(self.coordinate.x - entity[cl].coordinate.x, self.coordinate.y - entity[cl].coordinate.y)
            if (curDist < distance){
                self.ownClass = entity[cl]
                distance = curDist
            }
        }
    }
    
    func resetClass(){
        self.ownClass = nil
    }
    
    init(coord: (CGFloat,CGFloat)){
        self.coordinate.x = coord.0
        self.coordinate.y = coord.1
    }
    
    deinit{
        self.ownClass = nil
    }
}
