//
//  GuessViewController.swift
//  GuessSpokenNumber
//
//  Created by Johnny Do Amaral Ribeiro on 24/07/19.
//  Copyright © 2019 Johnny Do Amaral Ribeiro. All rights reserved.
//

import UIKit
import AVKit

class GuessViewController: UIViewController {
    
    var numberToGuess: Int?
    var wrongNumber: Int?
    var numberOfCoins = 3
    var score = 0
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var remainingCoinsLabel: UILabel!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var startButton: UIButton!
    
    @IBAction func pressGuessButtonLeft(_ sender: UIButton) {
        updateScoreAndCoinsLeft(sender)
    }
    
    @IBAction func pressGuessButtonRight(_ sender: UIButton) {
        updateScoreAndCoinsLeft(sender)
    }
    
    @IBAction func start(_ sender: Any) {
        numberToGuess = generateRandomNumber(upperBound: 100)
        wrongNumber = generateRandomNumber(upperBound: 100)
        let flipCoin = generateRandomNumber(upperBound: 2)
        
        assignNumberToGuessToOneOfTheButtons(flipCoin)
        
        vocalizeNumber()
    }
    
    fileprivate func generateRandomNumber(upperBound: UInt32) -> Int{
        return Int(arc4random_uniform(upperBound))
    }
    
    fileprivate func vocalizeNumber() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        let numberAsText = numberFormatter.string(for: numberToGuess)
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: numberAsText!)
        synthesizer.speak(utterance)
    }
    
    fileprivate func assignNumberToGuessToOneOfTheButtons(_ flipCoin: Int) {
        if flipCoin == 0 {
            leftButton.setTitle("\(numberToGuess!)", for: .normal)
            leftButton.tag = numberToGuess!
            rightButton.setTitle("\(wrongNumber!)", for: .normal)
            rightButton.tag = wrongNumber!
        } else {
            rightButton.setTitle("\(numberToGuess!)", for: .normal)
            rightButton.tag = numberToGuess!
            leftButton.setTitle("\(wrongNumber!)", for: .normal)
            leftButton.tag = wrongNumber!
        }
    }
    
    fileprivate func updateScoreAndCoinsLeft(_ sender: UIButton) {
        if sender.tag == numberToGuess {
            score = score + 1
            scoreLabel.text = "Score: \(score)"
            start(startButton)
        } else {
            numberOfCoins = numberOfCoins - 1
            if numberOfCoins == 0 {
                performSegue(withIdentifier: "gameOver", sender: nil)
            }
            remainingCoinsLabel.text = "Coins: \(numberOfCoins)"
            start(startButton)
        }
    }
    @IBAction func playAgain(_ sender: Any) {
        performSegue(withIdentifier: "goBackFromGameOver", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
