//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Gareth O'Sullivan on 16/08/2017.
//  Copyright © 2017 Locust Redemption. All rights reserved.
//

import UIKit
import AVFoundation

class CalculatorViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var initialValue = ""
    var additionalValue = ""
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        outputLabel.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    @IBAction func divideBtnPressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    @IBAction func multiplyBtnPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    @IBAction func subtractBtnPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    @IBAction func addBtnPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    @IBAction func equalBtnPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    @IBAction func clearBtnPressed(sender: AnyObject) {
        resetValues()
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" && initialValue != "" {
                additionalValue = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Divide {
                    result = "\(Double(initialValue)! / Double(additionalValue)!)"
                } else if currentOperation == Operation.Multiply {
                    result = "\(Double(initialValue)! * Double(additionalValue)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(initialValue)! - Double(additionalValue)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(initialValue)! + Double(additionalValue)!)"
                }
                initialValue = result
                outputLabel.text = result
            }
            currentOperation = operation
        } else {
            initialValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    func resetValues() {
        playSound()
        runningNumber = ""
        currentOperation = Operation.Empty
        initialValue = ""
        additionalValue = ""
        result = ""
        outputLabel.text = "0"
    }


}

