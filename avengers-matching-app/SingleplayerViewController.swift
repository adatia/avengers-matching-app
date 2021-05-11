//
//  SingleplayerViewController.swift
//  Adatia_Shayn_MatchingApp
//
//  Created by Period Two on 2019-05-06.
//  Copyright © 2019 Period Two. All rights reserved.
//

import UIKit

class SingleplayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()

        // Do any additional setup after loading the view.
    }

    //reloads the saved array
    func loadData() {
        if let loadNames: [String] = UserDefaults.standard.value(forKey: "save") as? [String] {
            savedData = loadNames
        }
    }
    
    //creates variables to save scores and names
    var savedData: [String] = []
    var savedScores = UserDefaults.standard
    var superScore = ""
    
    //allows access to leaderboard variables
    let leaderboard = LeaderboardViewController()
    
    //creates the outlet collection for the buttons
    @IBOutlet var positions: [UIButton]!
    
    //creates an outlet that contains all of the images to be used within the game
    var avengers: [UIImage] = [#imageLiteral(resourceName: "Black Panther.png"),#imageLiteral(resourceName: "Black Widow.png"),#imageLiteral(resourceName: "Captain America.png"),#imageLiteral(resourceName: "Hulk.png"),#imageLiteral(resourceName: "Iron Man.png"),#imageLiteral(resourceName: "Spider-Man.png"),#imageLiteral(resourceName: "Star-Lord.png"),#imageLiteral(resourceName: "Thor.png"),#imageLiteral(resourceName: "Black Panther.png"),#imageLiteral(resourceName: "Black Widow.png"),#imageLiteral(resourceName: "Captain America.png"),#imageLiteral(resourceName: "Hulk.png"),#imageLiteral(resourceName: "Iron Man.png"),#imageLiteral(resourceName: "Spider-Man.png"),#imageLiteral(resourceName: "Star-Lord.png"),#imageLiteral(resourceName: "Thor.png")]
    
    //creates empty variables of type UIImage to store the pictures of buttons
    var image1: UIImage = UIImage()
    var image2: UIImage = UIImage()
    
    //creates empty variables to store the tags of the sender buttons
    var button1 = 0
    var button2 = 0
    
    //creates variables for the score, the number of buttons pressed, the amount of matches made and the combo score multiplier
    var score = 0
    var buttonsPressed = 0
    var matches = 0
    var combo = 1
    
    //creates an empty array to be used for shuffling
    var shuffledAvengers: [UIImage] = []
    
    //creates index variables to be used with later functions
    var myIndex = 0
    var myIndex2 = 0
    
    //creates outlets for the score label and the start, give up and new game buttons
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var giveUpButton: UIButton!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    //creates the action for the start game button
    @IBAction func startGame(_ sender: UIButton) {
        
        //hides the start game button with an animation
        UIButton.transition(with: startButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.startButton.setImage(#imageLiteral(resourceName: "Start"), for: .normal)}, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.startButton.isHidden = true
        }
        
        //reveals the give up button with an animation
        giveUpButton.isHidden = false
        UIButton.transition(with: giveUpButton, duration: 0.7, options: .transitionFlipFromBottom, animations: {self.giveUpButton.setImage(#imageLiteral(resourceName: "GiveUp"), for: .normal)}, completion: nil)
        
        //enables user interaction for every button
        for position in positions {
            position.isUserInteractionEnabled = true
        }
        
        //shuffles the images
        avengers.shuffle()
        for index in avengers.reversed() {
            shuffledAvengers.append(index)
        }
        
    }
    
    //creates a function to display an alert box at the end of the game
    func win () {
        let alertController = UIAlertController(title: "Game Over", message:
            "Well done! Your score was \(score)!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default))
        alertController.addAction(UIAlertAction(title: "Enter the leaderboard", style: .default, handler: { action in
           
            self.saveData()
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //creates a function that animates any given button back to the default avengers logo
    func reset(myButton: UIButton) {
        UIButton.transition(with: myButton, duration: 0.4, options: .transitionFlipFromLeft, animations: {myButton.setImage(#imageLiteral(resourceName: "avengerslogo.png"), for: .normal)}, completion: nil)
    }
    
    //creates a function that reveals all of the unmatched images
    func myDelay() {
        
        //disables user interaction for every button
        for position in positions {
            position.isUserInteractionEnabled = false
        }
        
        //checks to see if every button's image property is equal to the default avengers logo
        if self.positions[self.myIndex].currentImage == #imageLiteral(resourceName: "avengerslogo.png") {
            
        //after 0.4 seconds, reveals the image with an animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            UIButton.transition(with: self.positions[self.myIndex], duration: 0.4, options: .transitionFlipFromLeft, animations: {self.positions[self.myIndex].setImage(self.shuffledAvengers[self.myIndex], for: .normal)}, completion: nil)
            
            //increments the index variable
            self.myIndex += 1
            
            //checks to see if the index is equal to 16, when it is, reveals the new game button with an animation and hides the give up button with an animation
            if self.myIndex == 16 {
                self.newGameButton.isHidden = false
                UIButton.transition(with: self.newGameButton, duration: 0.7, options: .transitionFlipFromBottom, animations: {self.newGameButton.setImage(#imageLiteral(resourceName: "NewGame"), for: .normal)}, completion: nil)
                UIButton.transition(with: self.giveUpButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.giveUpButton.setImage(#imageLiteral(resourceName: "GiveUp"), for: .normal)}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.giveUpButton.isHidden = true
                }
                return
            }
            self.myDelay()
            }
            } else {
            
                //increments the index variable
                myIndex += 1
            
                //checks to see if the index is equal to 16, when it is, reveals the new game button with an animation and hides the give up button with an animation
                if myIndex == 16 {
                    newGameButton.isHidden = false
                    UIButton.transition(with: newGameButton, duration: 0.7, options: .transitionFlipFromBottom, animations: {self.newGameButton.setImage(#imageLiteral(resourceName: "NewGame"), for: .normal)}, completion: nil)
                    UIButton.transition(with: giveUpButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.giveUpButton.setImage(#imageLiteral(resourceName: "GiveUp"), for: .normal)}, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        self.giveUpButton.isHidden = true
                    }
                    return
                }
                self.myDelay()
            }
    }
    
    //creates a function to reset all of the images to the default avengers logo
    func resetAll() {
        
        //checks all of the buttons to see if their image is not equal to the default avengers logo
        if positions[myIndex2].currentImage != #imageLiteral(resourceName: "avengerslogo.png") {
            
        //after 0.4 seconds, reverts the image back to the default avengers logo with an animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            UIButton.transition(with: self.positions[self.myIndex2], duration: 0.4, options: .transitionFlipFromLeft, animations: {self.positions[self.myIndex2].setImage(#imageLiteral(resourceName: "avengerslogo.png"), for: .normal)}, completion: nil)
            
            //increments the index variable
            self.myIndex2 += 1
            
            //stops if the index variable is equal to 16
            if self.myIndex2 == 16 {
                return
            }
            self.resetAll()
        }
        } else {
            
            //increments the index variable
            self.myIndex2 += 1
            
            //stops if the index variable is equal to 16
            if self.myIndex2 == 16 {
                return
            }
            self.resetAll()
        }
    }
    
    //creates the action for the give up button
    @IBAction func giveUp(_ sender: UIButton) {
        
        //runs the myDelay function and sets the index variable back to 0
        myDelay()
        myIndex = 0
    }
    
    //creates the action collection for all of the buttons
    @IBAction func position1Button(_ sender: UIButton) {
        
        //increments the buttons pressed variable
        buttonsPressed += 1
        
        //if one button is pressed, sets the button1 variable to the tag of the sender, disables user interaction for the sender and reveals the images with an animation
        if buttonsPressed == 1 {
            button1 = sender.tag
            sender.isUserInteractionEnabled = false
            UIButton.transition(with: positions[button1], duration: 0.4, options: .transitionFlipFromLeft, animations: {sender.setImage(self.shuffledAvengers[self.button1], for: .normal)}, completion: nil)
        }
        
        //checks to see if two buttons are pressed
        if buttonsPressed == 2 {
            
            //resets the buttons pressed variable
            buttonsPressed = 0
            
            //sets the button2 variable to the tag of the sender
            button2 = sender.tag
            
            //disables user interaction for every button
            for position in positions {
                position.isUserInteractionEnabled = false
            }
            
            //reveals the image with an animation
            UIButton.transition(with: positions[button2], duration: 0.4, options: .transitionFlipFromLeft, animations: {sender.setImage(self.shuffledAvengers[self.button2], for: .normal)}, completion: nil)
            
            //checks to see if the images of the two buttons pressed are equal, if they are, increments matches, adds the value of combo to the score, multiplies combo by 2, disables the buttons and reenables user interaction for every other button
            if positions[button1].image(for: .normal) == positions[button2].image(for: .normal) {
                matches += 1
                score += combo
                combo *= 2
                scoreLabel.text = String(score)
                positions[button1].isEnabled = false
                positions[button2].isEnabled = false
                for position in positions {
                    position.isUserInteractionEnabled = true
                }
            } else {
                
                //if the images of the buttons pressed do not match, resets the combo variable to 1, resets the images of the buttons back to default the avengers logo and reenables user interaction for every button
                combo = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                    self.reset(myButton: self.positions[self.button1])
                    self.reset(myButton: self.positions[self.button2])
                    for position in self.positions {
                        position.isUserInteractionEnabled = true
                    }
                })
            }
            
            //checks to see if there are 8 matches
            if matches == 8 {
                
                //runs the game over alert box function
                win()
                
                //hides the give up button with an animation
                UIButton.transition(with: giveUpButton, duration: 0.7, options: .transitionFlipFromBottom, animations: {self.giveUpButton.setImage(#imageLiteral(resourceName: "GiveUp"), for: .normal)}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.giveUpButton.isHidden = true
                }
                
                //reveals the new game button with an animation
                newGameButton.isHidden = false
                UIButton.transition(with: newGameButton, duration: 0.7, options: .transitionFlipFromBottom, animations: {self.newGameButton.setImage(#imageLiteral(resourceName: "NewGame"), for: .normal)}, completion: nil)
            }
        
        }
        
    }
    
    //creates the action for the new game button
    @IBAction func newGame(_ sender: UIButton) {
        //resets the index variable
        myIndex2 = 0
        
        //reenables every button but disables user interaction for every button
        for position in positions {
            position.isEnabled = true
            position.isUserInteractionEnabled = false
        }
        
        //runs the reset all function
        resetAll()
        
        //hides the new game button with an animation
        UIButton.transition(with: newGameButton, duration: 0.7, options: .transitionFlipFromBottom, animations: {self.newGameButton.setImage(#imageLiteral(resourceName: "NewGame"), for: .normal)}, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.newGameButton.isHidden = true
        }
        
        //resets all of the game's variables and arrays
        myIndex = 0
        matches = 0
        combo = 1
        score = 0
        scoreLabel.text = String(score)
        avengers = [#imageLiteral(resourceName: "Black Panther.png"),#imageLiteral(resourceName: "Black Widow.png"),#imageLiteral(resourceName: "Captain America.png"),#imageLiteral(resourceName: "Hulk.png"),#imageLiteral(resourceName: "Iron Man.png"),#imageLiteral(resourceName: "Spider-Man.png"),#imageLiteral(resourceName: "Star-Lord.png"),#imageLiteral(resourceName: "Thor.png"),#imageLiteral(resourceName: "Black Panther.png"),#imageLiteral(resourceName: "Black Widow.png"),#imageLiteral(resourceName: "Captain America.png"),#imageLiteral(resourceName: "Hulk.png"),#imageLiteral(resourceName: "Iron Man.png"),#imageLiteral(resourceName: "Spider-Man.png"),#imageLiteral(resourceName: "Star-Lord.png"),#imageLiteral(resourceName: "Thor.png")]
        shuffledAvengers = []
        
        //after 6.4 seconds, reveals the start button
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.55) {
            self.startButton.isHidden = false
        }
    }
    
    func saveData() {
        let alert = UIAlertController(title: "Enter your name", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your name here..."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            switch self.score {
            case 0...9:
                self.superScore = "00\(self.score)"
            case 10...99:
                self.superScore = "0\(self.score)"
            default:
                self.superScore = String(self.score)
            }
            
            self.savedData.append("Score: \(self.superScore), Player: \((alert.textFields?.first!.text)!)")
            self.savedScores.set(self.savedData, forKey: "save")
            
        }))
        
        self.present(alert, animated: true)

    }
    
}
