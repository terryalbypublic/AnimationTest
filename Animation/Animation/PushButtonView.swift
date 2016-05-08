//
//  PushButtonView.swift
//  Animation
//
//  Created by Alberti Terence on 05/05/16.
//  Copyright © 2016 TA. All rights reserved.
//

import UIKit

@IBDesignable

class PushButtonView: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.greenColor()
    @IBInspectable var isAddButton: Bool = true

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
        //set up the width and height variables
        //for the horizontal stroke
        let plusHeight: CGFloat = 3.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
        
        //create the path
        let plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = plusHeight
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2 - plusWidth/2 + 0.5,
            y:bounds.height/2 + 0.5))
        
        //add a point to the path at the end of the stroke
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2 + plusWidth/2 + 0.5,
            y:bounds.height/2 + 0.5))
        
        //set the stroke color
        UIColor.whiteColor().setStroke()
        
        //draw the stroke
        plusPath.stroke()
        
        if(self.isAddButton){
            
            let secondPath = UIBezierPath()
            
            secondPath.lineWidth = plusHeight
            
            secondPath.moveToPoint(CGPoint(x:bounds.height/2 + 0.5, y:bounds.width/2 - plusWidth/2 + 0.5))
            
            secondPath.addLineToPoint(CGPoint(x:bounds.height/2 + 0.5,y:bounds.width/2 + plusWidth/2 + 0.5))
            
            secondPath.stroke()
        }
    }
}
