//
//  ViewController.swift
//  Animation
//
//  Created by Alberti Terence on 02/05/16.
//  Copyright © 2016 TA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pushButtonView: TimerView!
    @IBOutlet weak var counterLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        pushButtonView.startLoadAnimation()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    @IBOutlet weak var plusButtonTapped: PushButtonView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func plusButtonTapped(sender: AnyObject) {
        pushButtonView.startTimerAnimation()
    }
    
    
    
    
    @IBAction func minusButtonTapped(sender: AnyObject) {
        pushButtonView.resetTimer()
    }

}

