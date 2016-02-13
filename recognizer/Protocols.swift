//
//  Protocols.swift
//  recognizer
//
//  Created by Andrew Johnsson on 11.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import UIKit

protocol GeneratorDelegate: class{
    func generate(points:Int, classes:Int)
}

protocol LoggerDelegate: class{
    func logPoint(x:CGFloat, y: CGFloat)
}