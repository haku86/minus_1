//
//  GameViewController.swift
//  Minus 1
//
//  Created by Joel Tan on 27/3/15.
//  Copyright (c) 2015 Joel Tan. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var timer = NSTimer()
    var count = 0
    var result = ""
    var time = 0
    var topScore = [10000]
    
    var gameLevel = 100
    var gameCount = 100
    var gameState = true
    
    @IBOutlet weak var gameCountLabel: UILabel!
    @IBOutlet weak var helperLabel: UILabel!
    @IBOutlet weak var outcomeLabel: UILabel!
    
    @IBOutlet weak var minusOneOutlet: UIButton!
    @IBAction func minusOne(sender: AnyObject) {
        if gameState == true {
            if gameCount == gameLevel {
                // if first pressed start timer and minus 1
                startGame()
                gameCount -= 1
                gameCountLabel.text = "\(gameCount)"
                // -1 animation function
            } else if gameCount > 0 {
                gameCount -= 1
                gameCountLabel.text = "\(gameCount)"
                // -1 animation function
                
                if gameCount == 0{
                    endGame()
                }
            }
        } else {
            restartGame()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        gameCountLabel.text = "\(gameCount)"
        if NSUserDefaults.standardUserDefaults().objectForKey("topScore") != nil {
            topScore = NSUserDefaults.standardUserDefaults().objectForKey("topScore") as [Int]
        }
    }
    
    
    func startGame(){
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("runTimer"), userInfo: nil, repeats: true)
    }
    
    func endGame(){
        timer.invalidate()
        println(time)
        saveResult()
        gameState = false
        gameCountLabel.text = result
        helperLabel.text = "Your Results"
        if time < topScore[0] {
            outcomeLabel.text = "You have broke the speed barrier at " + result
        } else {
            var min = topScore[0] / 600
            var sec = (topScore[0] - (min*600)) / 10
            var msec = topScore[0] - (min*600) - (sec*10)
            var secString = "00"
            if sec < 10 {
                secString = "0\(sec)"
            } else {
                secString = "\(sec)"
            }
            outcomeLabel.text = "You failed to break the record of " + "\(min):" + secString + ".\(msec)" + ". Please try again."
        }

        UIView.animateWithDuration(0.1, animations: {
            self.minusOneOutlet.alpha = 0
        })
        minusOneOutlet.setImage(UIImage(named:"Restart Button.png"),forState:UIControlState.Normal)
        minusOneOutlet.setImage(UIImage(named:"Restart Button.png"),forState:UIControlState.Highlighted)
        UIView.animateWithDuration(4, animations: {
            self.minusOneOutlet.alpha = 1.0
        })
        // figure out a way to delay the ability to press


    }
    
    func restartGame(){
        gameState = true
        count = 0
        time = 0
        result = ""
        gameCount = gameLevel
        gameCountLabel.text = "\(gameLevel)"
        helperLabel.text = "How fast can you go?"
        outcomeLabel.text = ""
        minusOneOutlet.setImage(UIImage(named:"Action Button.png"),forState:UIControlState.Normal)
        minusOneOutlet.setImage(UIImage(named:"Action Button Pressed.png"),forState:UIControlState.Highlighted)
    }
    
    func runTimer() {

        count++
        var min = count / 600
        var sec = (count - (min*600)) / 10
        var msec = count - (min*600) - (sec*10)
        var secString = "00"
        if sec < 10 {
            secString = "0\(sec)"
        } else {
            secString = "\(sec)"
        }
        result = "\(min):" + secString + ".\(msec)"
        time = count
        
    }
    
    func convertTime(){
        // create a convert time function
    }
    
    func saveResult() {
        if time < topScore[0] {
            topScore[0] = time
            NSUserDefaults.standardUserDefaults().setObject(topScore, forKey: "topScore")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
