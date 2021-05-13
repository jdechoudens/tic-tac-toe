//
//  breakout.swift
//  gamesDeChoudens
//
//  Created by period4 on 4/27/21.
//

import UIKit
import AVFoundation

class breakout: UIViewController, UICollisionBehaviorDelegate {

    @IBOutlet var circleView: UIView!
    @IBOutlet var padel: UIView!
    @IBOutlet var brickOne: UIView!
    @IBOutlet var brickTwo: UIView!
    @IBOutlet var brickThree: UIView!
    @IBOutlet var brickFour: UIView!
    @IBOutlet var brickFive: UIView!
    @IBOutlet var brickSix: UIView!
    @IBOutlet var brickSeven: UIView!
    @IBOutlet var brickEight: UIView!
    @IBOutlet var startButtonOut: UIButton!
    
    var dynamicAnimator : UIDynamicAnimator!
    var pushBehavior : UIPushBehavior!
    var collisionBehavior : UICollisionBehavior!
    var allBricks = [UIView]()
    var ballDynamicBehavior : UIDynamicItemBehavior!
    var padelDynamicBehavior : UIDynamicItemBehavior!
    var brickDynamicBehavior : UIDynamicItemBehavior!
    var brickCount = 8
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleView.layer.cornerRadius = 15
        allBricks = [brickOne, brickTwo, brickThree, brickFour, brickFive, brickSix, brickSeven, brickEight]
        circleView.isHidden = true
        padel.isHidden = true
    }
    @IBAction func startButton(_ sender: UIButton) {
    dynamicBehaviors()
    sender.isHidden = true
    padel.isHidden = false
    circleView.isHidden = false
    let sound = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: "Let's Go ... YEAH YEAH")
        sound.speak(utterance)
    }
    
    @IBAction func panG(_ sender: UIPanGestureRecognizer) {
    
        padel.center = CGPoint(x: sender.location(in: view).x , y: padel.center.y)
        dynamicAnimator.updateItem(usingCurrentState: padel)
    }
    
    
    func dynamicBehaviors() {
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        pushBehavior = UIPushBehavior(items: [circleView], mode: .instantaneous)
        pushBehavior.pushDirection = CGVector(dx: 0.7, dy: 0.7)
        pushBehavior.active = true
        pushBehavior.magnitude = 0.2
        dynamicAnimator.addBehavior(pushBehavior)
        
        collisionBehavior = UICollisionBehavior(items: [circleView, padel] + allBricks)
        collisionBehavior.collisionMode = .everything
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collisionBehavior)
        
        ballDynamicBehavior = UIDynamicItemBehavior(items: [circleView])
        ballDynamicBehavior.allowsRotation = false
        ballDynamicBehavior.elasticity = 0.2
        ballDynamicBehavior.friction = 0.0
        ballDynamicBehavior.resistance = 0.0
        ballDynamicBehavior.resistance = 0.0
        dynamicAnimator.addBehavior(ballDynamicBehavior)
        
        padelDynamicBehavior = UIDynamicItemBehavior(items: [padel])
        padelDynamicBehavior.friction = 0.0
        padelDynamicBehavior.density = 1000
        padelDynamicBehavior.elasticity = 1
        padelDynamicBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(padelDynamicBehavior)
        
        brickDynamicBehavior = UIDynamicItemBehavior(items: allBricks)
        brickDynamicBehavior.allowsRotation = false
        brickDynamicBehavior.density = 1000
        brickDynamicBehavior.elasticity = 1
        dynamicAnimator.addBehavior(brickDynamicBehavior)
        collisionBehavior.collisionDelegate = self
    }
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        
        brickCount = 8
        
        for brick in allBricks {
                if item1.isEqual(circleView) && item2.isEqual(brick) {
                    brick.isHidden = true
                    collisionBehavior.removeItem(brick)
                    brickCount = brickCount - 1
                    print(brickCount)
                    if brickCount == 0 {
                        winner()
                        circleView.isHidden = true
                        collisionBehavior.removeItem(circleView)
                        startButtonOut.isHidden = false
                        brickCount = 11
                        ballDynamicBehavior.resistance = 1000
                        for brick in allBricks{
                            
                            brick.isHidden = false
                        }
                    }
            }
        }
    }
    func reset() {

    }
    func alert() {
        
        let losingAlert = UIAlertController(title: "You lost", message: "womp womp womp", preferredStyle: .alert)
        
        present(losingAlert, animated: true, completion: nil)
        let newGameButton = UIAlertAction(title: "New Game?", style: .default) {
            (action) in self.reset()
        }
        losingAlert.addAction(newGameButton)
        present(losingAlert, animated: true, completion: nil)
        
        _ = AVSpeechSynthesizer()
        _ = AVSpeechUtterance(string: "You smell like you farted ... FARTED")
    }
    func winner() {
        let winningAlert = UIAlertController(title: "You Won", message: "Congrats", preferredStyle: .alert)
        
        present(winningAlert, animated: true, completion: nil)
        let newGameButton = UIAlertAction(title: "New Game?", style: .default) {
            (action) in self.reset()
            
            _ = AVSpeechSynthesizer()
            _ = AVSpeechUtterance(string: "Everybody gangster 'till you walking")
        }
        winningAlert.addAction(newGameButton)
        present(winningAlert, animated: true, completion: nil)
    }
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        if p.y > padel.center.y + 20 {
            reset()
            alert()
        }
    }
}

