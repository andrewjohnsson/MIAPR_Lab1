//
//  ClassPoint.swift
//  recognizer
//
//  Created by Andrew Johnsson on 13.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import UIKit

class ClassPoint: Point{
    var points: [Point] = []
    private var color: CGColor = UIColor.whiteColor().CGColor
    
    func addPoint(pt: Point){
        self.points.append(pt)
    }
    
    func getColor() -> CGColor{
        return self.color
    }
    
    override init() {
        super.init()
        self.color = UIColor(hue: CGFloat(arc4random() % 256) / 256,
                            saturation: CGFloat(arc4random() % 64) / 256 + 0.5,
                            brightness: CGFloat(arc4random() % 128) / 256 + 0.5,
                            alpha: 1).CGColor
    }
}
