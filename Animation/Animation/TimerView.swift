//
//  CounterView.swift
//  Animation
//
//  Created by Alberti Terence on 05/05/16.
//  Copyright © 2016 TA. All rights reserved.
//

import UIKit

let LoadMaxPortions = 1000
let InitialMilliseconds = 150000
var IsLoaded = false
var IsRunning = false
let π:CGFloat = CGFloat(M_PI)


@IBDesignable public class TimerView: UIView {
    
    var timerSeconds: Int {
        get {
            return InitialMilliseconds/1000 - ellapsedTime/1000
        }
    }
    
    @IBOutlet weak var timerLabel: UILabel!
    var loadTimerPortions = 0
    var ellapsedTime = 0
    var timer : NSTimer = NSTimer()
    var displayLinkTimer : CADisplayLink = CADisplayLink()
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor.orangeColor()
    
    
    override public func drawRect(rect: CGRect) {
        
        self.timerLabel.text = timeFormatted(self.timerSeconds)
        
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        let arcWidth: CGFloat = 20
        
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4
        
        
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        let arcLengthPerGlass = angleDifference / CGFloat(LoadMaxPortions)
        
        var finalEndAngle = arcLengthPerGlass * CGFloat(loadTimerPortions) + startAngle
        
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: finalEndAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        let arcLengthWithTime = angleDifference / CGFloat(InitialMilliseconds)
        finalEndAngle = arcLengthWithTime * CGFloat(ellapsedTime) + startAngle
        
        let path2 = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: finalEndAngle,
                                clockwise: true)
        
        path2.lineWidth = arcWidth
        outlineColor.setStroke()
        path2.stroke()
        
    }
    
    // public methods
    
    // start the animation loading
    public func startLoadAnimation(){
        self.displayLinkTimer = CADisplayLink(target: self, selector: #selector(updateLoading))
        displayLinkTimer.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    
    // animation when the timer is started
    public func startTimerAnimation(){
        if(IsLoaded && !IsRunning){
            IsRunning = true
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            
            self.displayLinkTimer = CADisplayLink(target: self, selector: #selector(updateTimer))
            displayLinkTimer.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        }
    }
    
    // set timer to the initial time
    public func resetTimer(){
        if(IsLoaded && IsRunning){
            IsRunning = false
            self.ellapsedTime = 0
            self.timer.invalidate()
            self.displayLinkTimer.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            self.setNeedsDisplay()
        }
    }
    
    
    // private methods
    
    func updateTime(){
        self.ellapsedTime += 50;
    }
    
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // UI callbacks updater
    func updateTimer(){
        if(ellapsedTime == InitialMilliseconds){
            self.displayLinkTimer.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            IsLoaded = true
            
        }
        else{
            self.setNeedsDisplay()
        }
    }
    
    func updateLoading(){
        if(loadTimerPortions == LoadMaxPortions){
            self.displayLinkTimer.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            IsLoaded = true
            
        }
        else{
            loadTimerPortions += 20
            self.setNeedsDisplay()
        }
    }
}
