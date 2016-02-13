//
//  ClassPoint.swift
//  recognizer
//
//  Created by Andrew Johnsson on 13.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import UIKit

class ClassPoint: Point{
    var ownPoints: [Point] = []
    var color: CGColor?
    
    func getOwnPoints() -> [Point]{
        return self.ownPoints
    }
    
    func getColor() -> CGColor{
        guard self.color == nil else{
            return self.color!
        }
        return UIColor.whiteColor().CGColor
    }
    
    func setColor(color: CGColor){
        self.color = color
    }
    
    func resetOwnPoints(){
        self.ownPoints = []
    }
}
