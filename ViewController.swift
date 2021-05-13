//
//  ViewController.swift
//  gamesDeChoudens
//
//  Created by period4 on 4/5/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var labelOne: UILabel!
    @IBOutlet var labelTwo: UILabel!
    @IBOutlet var labelThree: UILabel!
    @IBOutlet var labelFour: UILabel!
    @IBOutlet var labelFive: UILabel!
    @IBOutlet var labelSix: UILabel!
    @IBOutlet var labelSeven: UILabel!
    @IBOutlet var labelEight: UILabel!
    @IBOutlet var labelNine: UILabel!
    @IBOutlet var myView: UIView!
    @IBOutlet var TurnLabel: UILabel!
    
    var allLabels : [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    allLabels = [labelOne, labelTwo, labelThree, labelFour, labelFive, labelSix, labelSeven, labelEight, labelNine]
    }
    func checkForWinner() {

        if labelOne.text == labelTwo.text && labelTwo.text == labelThree.text  && labelOne.text != ""
            {
            alert()
            }
        if labelOne.text == labelFour.text && labelFour.text == labelSeven.text && labelOne.text != ""
            {
            alert()
            }
        if labelOne.text == labelFive.text && labelFive.text == labelNine.text && labelOne.text != ""
            {
            alert()
            }
        if labelTwo.text == labelFive.text && labelFive.text == labelSeven.text && labelTwo.text != ""
            {
            alert()
            }
        if labelThree.text == labelSix.text && labelSix.text == labelNine.text && labelThree.text != ""
            {
            alert()
            }
                              
        if labelThree.text == labelFive.text && labelFive.text == labelSeven.text && labelThree.text != ""
            {
            alert()
            }
                                
        if labelFour.text == labelFive.text && labelFive.text == labelSix.text && labelFour.text != ""
            {
            alert()
            }
        if labelSeven.text == labelEight.text && labelEight.text == labelNine.text && labelSeven.text != ""
            {
            alert()
            }
    
    }
            
    @IBAction func resetButton(_ sender: Any) {
    
        reset()
    }
            //Use the parameter in conditional

        func placeInToLabel(myLabel: UILabel) {

            if myLabel.text == ""
            
            {
                if TurnLabel.text == "X" {
                myLabel.text = TurnLabel.text
                TurnLabel.text = "O"
                }
            else {
                
                myLabel.text = TurnLabel.text
                TurnLabel.text = "X"
            }
            }
        }

                func reset() {
                        
                    for label in allLabels {
                        label.text = ""
                        print(label)
                    }
                }
    @IBAction func tapGesture(sender: UITapGestureRecognizer) {
   
        let selectedPoint = sender.location(in: myView)
        for label in allLabels {
            if label.frame.contains(selectedPoint) {
            
                placeInToLabel(myLabel: label)
            }
        }
    checkForWinner()
    }
        func alert() {
            
            let winningAlert = UIAlertController(title: "You won", message: "way to go", preferredStyle: .alert)
            
            present(winningAlert, animated: true, completion: nil)
            let newGameButton = UIAlertAction(title: "New Game?", style: .default) {
                (action) in self.reset()
            }
            winningAlert.addAction(newGameButton)
            present(winningAlert, animated: true, completion: nil)
        }
    }
