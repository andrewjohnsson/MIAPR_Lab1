//
//  Log.swift
//  recognizer
//
//  Created by Andrew Johnsson on 11.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import UIKit

class Log: LoggerDelegate{
    
    var pointsLog: [String]
    
    init(){
        self.pointsLog = [""]
        self.pointsLog.append("Points log\n")
    }
    
    func logPoint(x:CGFloat, y: CGFloat){
        pointsLog.append("\n" + String(NSDate()) + "    Point(" + String(x) + ", " + String(y) + ")")
    }
}
