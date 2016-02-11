//
//  ViewController.swift
//  recognizer
//
//  Created by Andrew Johnsson on 02.02.16.
//  Copyright © 2016 gingercode. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, GeneratorDelegate{
    @IBOutlet weak var canvas: UIImageView!
    
    weak var delegate: LoggerDelegate?
    
    @IBAction func showOptions(sender: AnyObject) {
        performSegueWithIdentifier("toggleOptions", sender: self)
    }
    
    @IBAction func clear(sender: AnyObject) {
        canvas.layer.sublayers = nil
    }
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toggleOptions"{
            let optionsPopover:OptionsPopoverController = segue.destinationViewController as! OptionsPopoverController
            optionsPopover.modalPresentationStyle = UIModalPresentationStyle.Popover
            optionsPopover.popoverPresentationController!.delegate = self
            optionsPopover.delegate = self
        }
    }
    
    class Point{
        var x: CGFloat
        var y: CGFloat
        
        func getDistance(x: CGFloat, y: CGFloat) -> CGFloat{
            let distance = hypot(self.x-x, self.y-y)
            return distance
        }
        
        init(x: CGFloat, y: CGFloat){
            self.x = x
            self.y = y
        }
    }
    
    class PointClass: Point{
        var ownPoints: [Point] = []
        
        func assignPoint(point: Point){
            self.ownPoints.append(point)
        }
        
        func getOwnPoints() -> [Point]{
            return self.ownPoints
        }
    }
    
    func generatePoints(points:Int, classes:Int){
        var pointsEntity: [Point] = []
        var classesEntity: [PointClass] = []
        
        for _ in 1...points{
            pointsEntity.append(Point(x: CGFloat(arc4random() % UInt32(canvas.bounds.size.width)), y: CGFloat(arc4random() % UInt32(canvas.bounds.size.height))))
        }
        
        for _ in 1...classes{
            classesEntity.append(PointClass(x: CGFloat(arc4random() % UInt32(canvas.bounds.size.width)), y: CGFloat(arc4random() % UInt32(canvas.bounds.size.height))))
        }
        
        assignClasses(pointsEntity, classesEntity: classesEntity)
    }
    
    func assignClasses(pointsEntity: [Point], classesEntity: [PointClass]){
        for point in 0...pointsEntity.count-1{
            var minDistance: CGFloat = 9999
            var cl = 0
            for classPoint in 0...classesEntity.count-1{
                let distance = pointsEntity[point].getDistance(classesEntity[classPoint].x, y: classesEntity[classPoint].y)
                if (distance <= minDistance){
                    minDistance = distance
                    cl = classPoint
                }
            }
            classesEntity[cl].assignPoint(pointsEntity[point])
        }
        drawPoints(pointsEntity, classes: classesEntity)
    }
    
    func drawPoints(points: [Point], classes: [PointClass]){
        canvas.layer.sublayers = nil
        
        var classesColors: [UIColor] = []
        
        for clPoint in 0...classes.count-1{
            let classDot = CAShapeLayer()
            let path = UIBezierPath.init(ovalInRect: CGRectMake(0.0, 0.0, 2.0, 2.0))
            classDot.path = path.CGPath

            let color = UIColor(hue: CGFloat(arc4random() % 256) / 256, saturation: CGFloat(arc4random() % 128) / 256 + 0.5, brightness: CGFloat(arc4random() % 128) / 256 + 0.5, alpha: 1)
            classesColors.append(color)
            
            classDot.strokeColor = color.CGColor
            classDot.lineWidth = 2
            classDot.bounds = CGRectMake(0.0, 0.0, 0.0, 0.0)
            //delegate?.logPoint(x, y: y)
            classDot.position = CGPointMake(classes[clPoint].x, classes[clPoint].y)
            canvas.layer.addSublayer(classDot)
        }
        classes[0].getOwnPoints()
        
        for clPoint in 0...classes.count-1{
            let points = classes[clPoint].getOwnPoints()
            for point in points{
                let dot = CAShapeLayer()
                let path = UIBezierPath.init(ovalInRect: CGRectMake(0.0, 0.0, 1.0, 1.0))
                dot.path = path.CGPath
                dot.strokeColor = classesColors[clPoint].CGColor
                dot.lineWidth = 1
                dot.bounds = CGRectMake(0.0, 0.0, 0.0, 0.0)
                //delegate?.logPoint(x, y: y)
                dot.position = CGPointMake(point.x,point.y)
                canvas.layer.addSublayer(dot)
            }
        }
    }
    
    override func viewDidLoad() {
        performSegueWithIdentifier("setDelegate", sender: self.view)
        super.viewDidLoad()
        //delegate?.logAppend(CGFloat(random() % Int(canvas.bounds.size.width)), y: CGFloat(random() % Int(canvas.bounds.size.height)))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

