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
    //var color: CGColor = UIColor.whiteColor().CGColor
    
    func setClass(cl: ClassPoint){
        self.ownClass = cl
    }
    
    func getClass() -> ClassPoint{
        return self.ownClass!
    }
    
    init(){
        self.coordinate.x = CGFloat(arc4random() % 500)
        self.coordinate.y = CGFloat(arc4random() % 500)
    }
}
