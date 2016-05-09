//
//  ViewController.swift
//  space-calculator
//
//  Created by Bhrigu Gupta on 08/05/16.
//  Copyright © 2016 Awwsome. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //my variable types
    enum operation : String {
        case Add = "+"
        case Multiply = "*"
        case Divide = "/"
        case Subtract = "-"
        case Clear = "clear"
        case Empty = "blank"
    }
    
    
    // my variabels
    var btnAudio : AVAudioPlayer!
    
    var displaynum : String = ""
    var oldnum : String!
    var newnum : String!
    var result : String!
    
    var currentOperation : operation!
    
    //my outlets
    @IBOutlet var appLogo : UIImageView!
    @IBOutlet var mainBg : UIImageView!
    @IBOutlet var startButton : UIButton!
    
    @IBOutlet var resultLbl : UILabel!
    @IBOutlet var calcBg : UIImageView!
    @IBOutlet var ground : UIImageView!
    @IBOutlet var calBack : UIStackView!
    @IBOutlet var calButtons : UIStackView!

    // my functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InitialiseEverything()
        
        let path = NSBundle.mainBundle().pathForResource("btnAudio", ofType: "wav")
        let audioURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnAudio = AVAudioPlayer(contentsOfURL: audioURL)
            btnAudio.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func playSound() {
        if btnAudio.playing {
            btnAudio.stop()
        }
        btnAudio.play()
    }
    
    func InitialiseEverything() {
        displaynum = ""
        oldnum = ""
        newnum = ""
        result = ""
        resultLbl.text = "0"
        currentOperation = operation.Empty
    }

    //my Actions
    @IBAction func startCalc(btn : UIButton) {
        appLogo.hidden = true
        mainBg.hidden = true
        startButton.hidden = true
        
        resultLbl.hidden = false
        calcBg.hidden = false
        ground.hidden = false
        calBack.hidden = false
        calButtons.hidden = false
    }
    
    @IBAction func ButtonPressed(btn: UIButton!) {
        playSound()
        
        displaynum += "\(btn.tag)"
        resultLbl.text = displaynum
    }
    
    @IBAction func AddBtnPressed(btn : UIButton!) {
        ProcessButton(operation.Add)
    }
    
    @IBAction func SubBtnPressed(btn : UIButton!) {
        ProcessButton(operation.Subtract)
    }

    @IBAction func MulBtnPressed(btn : UIButton!) {
        ProcessButton(operation.Multiply)
    }

    @IBAction func DivBtnPressed(btn : UIButton!) {
        ProcessButton(operation.Divide)
    }

    @IBAction func EqualBtnPressed(btn : UIButton!) {
        ProcessButton(currentOperation)
    }
    
    @IBAction func ClearBtnPressed(btn : UIButton!) {
        ProcessButton(operation.Clear)
    }
    
    func ProcessButton(op : operation) {
        if op == operation.Clear {
            InitialiseEverything()
        }
        else if displaynum == "" {
            if oldnum != "" {
                currentOperation = op
            }
        }
        else if currentOperation != operation.Empty {
            newnum = displaynum
            result = ""
            
            if currentOperation == operation.Add {
                result = "\(Double(oldnum)! + Double(newnum)!)"
            } else if currentOperation == operation.Multiply {
                result = "\(Double(oldnum)! * Double(newnum)!)"
            } else if currentOperation == operation.Divide {
                result = "\(Double(oldnum)! / Double(newnum)!)"
            } else if currentOperation == operation.Subtract {
                result = "\(Double(oldnum)! - Double(newnum)!)"
            }
            
            oldnum = result
            newnum = ""
            currentOperation = op
            
            displaynum = ""
            resultLbl.text = result
        }
        else {
            oldnum = displaynum
            displaynum = ""
            currentOperation = op
        }
    }

    
}

