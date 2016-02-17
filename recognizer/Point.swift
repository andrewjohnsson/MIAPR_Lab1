//
//  Point.swift
//  recognizer
//
//  Created by Andrew Johnsson on 13.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import UIKit

class Point{
    var coordinate: (x: UInt16, y: UInt16)
    
    init(){
        self.coordinate.x = UInt16(arc4random() % UInt32(UIScreen.mainScreen().bounds.size.width))
        self.coordinate.y = UInt16(arc4random() % UInt32(UIScreen.mainScreen().bounds.size.height-65))
    }
}
