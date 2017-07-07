//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Lukasz Marciniak on 25.05.2017.
//  Copyright © 2017 Lukasz Marciniak. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    enum Operation: String {
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Divide = "/"
        case Empty = "Empty"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL.init(fileURLWithPath: path!)
      
        do {
            try btnSound = AVAudioPlayer.init(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        processOperation(operation: Operation.Add)
    }
    
    @IBAction func subBtnPressed(_ sender: Any) {
        processOperation(operation: Operation.Subtract)
    }
    
    @IBAction func multiplyBtnPressed(_ sender: Any) {
        processOperation(operation: Operation.Multiply)
    }
    
    @IBAction func dividedBtnPressed(_ sender: Any) {
        processOperation(operation: Operation.Divide)
    }
    
    @IBAction func eqBtnPressed(_ sender: Any) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func clearBtn(_ sender: Any) {
        playSound()
        clear()
    }
    
    func clear() {
        result = "0"
        currentOperation = Operation.Empty
        outputLbl.text = result
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation){
        
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
              currentOperation = operation
        } else {
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    
}

    

