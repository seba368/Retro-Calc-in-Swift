//
//  ViewController.swift
//  retro calc swift
//
//  Created by Sebastian Brukalo on 11/27/15.
//  Copyright © 2015 Sebastian Brukalo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
            
        } catch let error as NSError {
            
            print(error.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(button: UIButton!){
        playSound()
        runningNumber += "\(button.tag)"
        outputLbl.text = runningNumber
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMulitplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
        
    }
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation){
        
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(rightValStr)! * Double(leftValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(rightValStr)! / Double(leftValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(rightValStr)! - Double(leftValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(rightValStr)! + Double(leftValStr)!)"
                    
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}

