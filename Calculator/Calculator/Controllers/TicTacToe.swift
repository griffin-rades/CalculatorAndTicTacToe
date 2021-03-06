//
//  MainViewController.swift
//  Calculator
//
//  Created by Griffin Rades on 10/25/19.
//  Copyright © 2019 Saint Mary's University. All rights reserved.
//

import UIKit

class TicTacToe: UIViewController {
    let gameBoardView = UIView()
    var xOrO = UISwitch()
    var playerLabel = UILabel()
    var informationLabel = UILabel()
    var startButton = UIButton(type: .system)
    var gameBoardButtons: [ticTacToeButtons] = []
    var gameBoardFinal: [String] = []
    var ticTacToeDictionary = [String: Any]()
    var gameStarted = false
    var playerTurnX = true
    var numberOfClicks = 0
    var isWinner = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.startButton.backgroundColor = .black
        self.informationLabel.backgroundColor = .black
        self.gameBoardView.backgroundColor = .gray
        self.playerLabel.backgroundColor = .black
        
        self.startButton.setTitle(NSLocalizedString("buttonLabelStart", comment: "Start"), for: .normal)
        self.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        self.startButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        
        self.playerLabel.text = NSLocalizedString("startingPlayer", comment: "Player: X")
        self.playerLabel.textAlignment = .center
        self.playerLabel.textColor = .white
        self.playerLabel.font = UIFont.systemFont(ofSize: 20)

        
        self.informationLabel.textColor = .white
        self.informationLabel.numberOfLines = 0
        self.informationLabel.textAlignment = .center
        self.informationLabel.text = NSLocalizedString("startingGameInformationLabel", comment: "The game is Tic-Tac-Toe. Use the switch at the top to decide who goes first, then after that alternate back and forth. The a winner will be decided automaticly when a player has 3 in row, collumn, or diagonal.")
        self.informationLabel.font = UIFont.systemFont(ofSize: 15)

        
        self.xOrO.addTarget(self, action: #selector(playerSlider), for: .touchUpInside)
    }
    
    override func loadView(){
        super.loadView()
        
        self.ticTacToeDictionary["switch"] = self.xOrO
        self.ticTacToeDictionary["gameBoard"] = self.gameBoardView
        self.ticTacToeDictionary["mainView"] = self.view
        self.ticTacToeDictionary["start"] = self.startButton
        self.ticTacToeDictionary["label"] = self.informationLabel
        self.ticTacToeDictionary["playerLabel"] = self.playerLabel
        
        createGameBoardButtons()
        
        gameScreenConstraints(portrait: true)
    }
    
    /*
     MARK: Rotation
     */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            gameScreenConstraints(portrait: false)
        } else{
            gameScreenConstraints(portrait: true)
        }
    }
    /*
     MARK: create the 9x9 game board.
     */
    func createGameBoardButtons(){
        for i in 0..<9{
            let x = ticTacToeButtons()
            
            x.title = "button" + String(i)
            x.buttonLabel = " "
            x.ticTacToeButton = UIButton(type: .system)
            x.ticTacToeButton?.setTitle(x.buttonLabel, for: .normal)
            x.ticTacToeButton?.tag = i
            x.ticTacToeButton?.backgroundColor = .white
            x.ticTacToeButton?.setTitleColor(.black, for: .normal)
            x.ticTacToeButton?.addTarget(self, action: #selector(gameButtonClicked), for: .touchUpInside)
            x.ticTacToeButton?.titleLabel?.font = UIFont.systemFont(ofSize: 40)
            self.ticTacToeDictionary[x.title!] = x.ticTacToeButton
            self.gameBoardButtons.append(x)
        }
    }
    /*
     MARK:Decide winner function
     Parameter: none
     Returns: boolean true if there is a winner
     */
    func decideWinner() -> Bool{
        self.gameBoardFinal.removeAll()
        var p = 0
        var numLetters = 0
        for x in gameBoardButtons{
            if let buttonTitle = x.buttonLabel{
                if buttonTitle != " "{
                    gameBoardFinal.append(buttonTitle)
                }else{
                    gameBoardFinal.append(String(p))
                }
            }
            if gameBoardFinal[p] == "X" || gameBoardFinal[p] == "O"{
                numLetters += 1
            }
            p += 1
        }
        
        //check the cases of a game winner or a draw
        if (gameBoardFinal[0] == gameBoardFinal[1]) && (gameBoardFinal[1] == gameBoardFinal[2]) && (gameBoardFinal[0] == gameBoardFinal[2]){
            self.informationLabel.text = NSLocalizedString("displayTheWinner", comment: "The winner is ") + gameBoardFinal[0]
            return true
        }else if (gameBoardFinal[3] == gameBoardFinal[4]) && (gameBoardFinal[4] == gameBoardFinal[5]) && (gameBoardFinal[3] == gameBoardFinal[5]){
            self.informationLabel.text = NSLocalizedString("displayTheWinner", comment: "The winner is ") + gameBoardFinal[3]
            return true
        }else if (gameBoardFinal[6] == gameBoardFinal[7]) && (gameBoardFinal[7] == gameBoardFinal[8]) && (gameBoardFinal[6] == gameBoardFinal[8]){
            self.informationLabel.text = NSLocalizedString("displayTheWinner", comment: "The winner is ") + gameBoardFinal[6]
            return true
        }else if (gameBoardFinal[0] == gameBoardFinal[3]) && (gameBoardFinal[3] == gameBoardFinal[6]) && (gameBoardFinal[0] == gameBoardFinal[6]){
            self.informationLabel.text = NSLocalizedString("displayTheWinner", comment: "The winner is ") + gameBoardFinal[0]
            return true
        }else if (gameBoardFinal[1] == gameBoardFinal[4]) && (gameBoardFinal[4] == gameBoardFinal[7]) && (gameBoardFinal[1] == gameBoardFinal[7]){
            self.informationLabel.text = NSLocalizedString("displayTheWinner", comment: "The winner is ") + gameBoardFinal[1]
            return true
        }else if (gameBoardFinal[2] == gameBoardFinal[5]) && (gameBoardFinal[5] == gameBoardFinal[8]) && (gameBoardFinal[2] == gameBoardFinal[8]){
            self.informationLabel.text = NSLocalizedString("displayTheWinner", comment: "The winner is ") + gameBoardFinal[2]
            return true
        }else if (gameBoardFinal[0] == gameBoardFinal[4]) && (gameBoardFinal[4] == gameBoardFinal[8]) && (gameBoardFinal[0] == gameBoardFinal[8]){
            self.informationLabel.text = NSLocalizedString("displayTheWinner", comment: "The winner is ") + gameBoardFinal[0]
            return true
        }else if (gameBoardFinal[2] == gameBoardFinal[4]) && (gameBoardFinal[4] == gameBoardFinal[6]) && (gameBoardFinal[2] == gameBoardFinal[6]){
            self.informationLabel.text = NSLocalizedString("displayTheWinner", comment: "The winner is ") + gameBoardFinal[2]
            return true
        }else if ((self.informationLabel.text == "Player O turn" || self.informationLabel.text == "Player X turn") && numLetters == 9){
            self.informationLabel.text = NSLocalizedString("drawText", comment: "Draw! There are no winners")
            return true
        }else{
            return false
        }
    }
    
    /*
     MARK: player slider
     Parameter: UISwitch
     Returns: void
     */
    @objc func playerSlider(_ sender: UISwitch){
        if sender.isOn{
            playerLabel.text = NSLocalizedString("playerO", comment: "Player: O")
            playerTurnX = false
        }else{
            playerLabel.text = NSLocalizedString("playerX", comment: "Player: X")
            playerTurnX = true
        }
    }
    
    /*
     MARK: Game Button Clicked
     Parameter: UIButton
     Returns: void
     */
    @objc func gameButtonClicked(_ sender: UIButton){
        if gameStarted && !isWinner{
            changeLabel(player: playerTurnX, whichButton: sender.tag)
            
            if playerTurnX{
                self.informationLabel.text = NSLocalizedString("playerO", comment: "Player: O")
                playerTurnX = false
            }else{
                self.informationLabel.text = NSLocalizedString("playerX", comment: "Player: X")
                playerTurnX = true
            }
            
            isWinner = decideWinner()
        }
    }
    
    /*
     MARK: Start clicked
     Parameter: UIButton
     Returns: void
     */
    @objc func startButtonClicked(_ sender: UIButton){
        self.gameStarted = true
        self.isWinner = false
        self.playerTurnX = true
        
        self.playerLabel.text = NSLocalizedString("playerX", comment: "Player: X")
        self.startButton.setTitle(NSLocalizedString("restartTheGame", comment: "Restart"), for: .normal)
        self.informationLabel.text = NSLocalizedString("durringGameInformation", comment: "GAME STARTED! Use the switch to decide who goes first.")
        
        self.xOrO.setOn(false, animated: true)
        
        for x in gameBoardButtons{
            x.buttonLabel = " "
            x.ticTacToeButton?.titleLabel?.text = x.buttonLabel
            x.ticTacToeButton?.setTitle("", for: .normal)
        }
    }
    
    /*
     MARK: Change the label
     Parameter: boolean true is player x and an interger to see what button was clicked
     Returns: void
     */
    func changeLabel(player: Bool, whichButton: Int){
        if player{
            gameBoardButtons[whichButton].buttonLabel = NSLocalizedString("playerXButtonLabel", comment: "X")
            gameBoardButtons[whichButton].ticTacToeButton?.setTitleColor(.red, for: .normal)
            gameBoardButtons[whichButton].ticTacToeButton?.setTitle(gameBoardButtons[whichButton].buttonLabel, for: .normal)
        }else{
            gameBoardButtons[whichButton].buttonLabel = NSLocalizedString("playerOButtonLabel", comment: "O")
            gameBoardButtons[whichButton].ticTacToeButton?.setTitleColor(.blue, for: .normal)
            gameBoardButtons[whichButton].ticTacToeButton?.setTitle(gameBoardButtons[whichButton].buttonLabel, for: .normal)
        }
    }
    
    /*
     MARK: Game Board Constraints
     Parameter: none
     Retuns: void
     */
    func gameBoardConstraints(){
        self.informationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.gameBoardView.addSubview(informationLabel)
        
        for i in gameBoardButtons{
            self.gameBoardView.addSubview(i.ticTacToeButton!)
            i.ticTacToeButton?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button0]-[button1(==button0)]-[button2(==button0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constraint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button3]-[button4(==button0)]-[button5(==button0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constraint2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button6]-[button7(==button0)]-[button8(==button0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constraint3 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constraint4 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[button0(>=60,<=100)]-[button3(==button0)]-[button6(==button0)]-[label]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constraint5 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[button1(==button0)]-[button4(==button0)]-[button7(==button0)]-[label]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constraint6 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[button2(==button0)]-[button5(==button0)]-[button8(==button0)]-[label]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        
        
        self.gameBoardView.addConstraints(constraint0)
        self.gameBoardView.addConstraints(constraint1)
        self.gameBoardView.addConstraints(constraint2)
        self.gameBoardView.addConstraints(constraint3)
        self.gameBoardView.addConstraints(constraint4)
        self.gameBoardView.addConstraints(constraint5)
        self.gameBoardView.addConstraints(constraint6)
    }
    
    /*
     MARK: Game Screen Constraints
     Parameter: boolean
     Returns: void
     */
    func gameScreenConstraints(portrait: Bool){
        self.xOrO.removeFromSuperview()
        self.gameBoardView.removeFromSuperview()
        self.startButton.removeFromSuperview()
        self.playerLabel.removeFromSuperview()
        
        self.xOrO.translatesAutoresizingMaskIntoConstraints = false
        self.gameBoardView.translatesAutoresizingMaskIntoConstraints = false
        self.startButton.translatesAutoresizingMaskIntoConstraints = false
        self.playerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if portrait{
            self.view.addSubview(xOrO)
            self.view.addSubview(gameBoardView)
            self.view.addSubview(startButton)
            self.view.addSubview(playerLabel)
            
            let constraint0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[start]-40-[switch]-40-[playerLabel(==start)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
            let constraint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[gameBoard]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
            let constraint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-150-[start(50)]-50-[gameBoard]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
            let constraint3 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-150-[switch]-50-[gameBoard]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
            let constraint4 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-150-[playerLabel]-50-[gameBoard]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)

            self.view.addConstraints(constraint0)
            self.view.addConstraints(constraint1)
            self.view.addConstraints(constraint2)
            self.view.addConstraints(constraint3)
            self.view.addConstraints(constraint4)
            
        }else{
            self.xOrO.removeFromSuperview()
            self.gameBoardView.removeFromSuperview()
            self.startButton.removeFromSuperview()
            self.playerLabel.removeFromSuperview()
            
            self.view.addSubview(xOrO)
            self.view.addSubview(gameBoardView)
            self.view.addSubview(startButton)
            self.view.addSubview(playerLabel)
            
            
            let constraint0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[start][gameBoard]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
            let constraint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[switch]-30-[gameBoard]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
            let constraint2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[playerLabel][gameBoard]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
            let constraint3 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[start(50)]-[switch]-[playerLabel(==start)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
            let constraint4 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[gameBoard]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)

            self.view.addConstraints(constraint0)
            self.view.addConstraints(constraint1)
            self.view.addConstraints(constraint2)
            self.view.addConstraints(constraint3)
            self.view.addConstraints(constraint4)
        }
        
        gameBoardConstraints()
    }
}
