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
        
        self.startButton.setTitle("Start", for: .normal)
        self.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        
        self.playerLabel.text = "Player: X"
        self.playerLabel.textAlignment = .center
        self.playerLabel.textColor = .white
        
        self.informationLabel.textColor = .white
        self.informationLabel.numberOfLines = 0
        self.informationLabel.textAlignment = .center
        self.informationLabel.text = "The game is Tic-Tac-Toe. Use the slider at the top to decide who goes first, then after that alternate back and forth. The a winner will be decided automaticly when a player has 3 in row, collumn, or diagonal."
    
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
        
        gameScreenConstraints()
        gameBoardConstraints()
    }
    
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
    
    func decideWinner() -> Bool{
        self.gameBoardFinal.removeAll()
        var p = 0
        for x in gameBoardButtons{
            if let buttonTitle = x.buttonLabel{
                if buttonTitle != " "{
                    gameBoardFinal.append(buttonTitle)
                }else{
                    gameBoardFinal.append(String(p))
                }
            }
            p += 1
        }

        if (gameBoardFinal[0] == gameBoardFinal[1]) && (gameBoardFinal[1] == gameBoardFinal[2]) && (gameBoardFinal[0] == gameBoardFinal[2]){
            self.informationLabel.text = "The winner is " + gameBoardFinal[0]
            return true
        }else if (gameBoardFinal[3] == gameBoardFinal[4]) && (gameBoardFinal[4] == gameBoardFinal[5]) && (gameBoardFinal[3] == gameBoardFinal[5]){
            self.informationLabel.text = "The winner is " + gameBoardFinal[3]
            return true
        }else if (gameBoardFinal[6] == gameBoardFinal[7]) && (gameBoardFinal[7] == gameBoardFinal[8]) && (gameBoardFinal[6] == gameBoardFinal[8]){
            self.informationLabel.text = "The winner is " + gameBoardFinal[6]
            return true
        }else if (gameBoardFinal[0] == gameBoardFinal[3]) && (gameBoardFinal[3] == gameBoardFinal[6]) && (gameBoardFinal[0] == gameBoardFinal[6]){
            self.informationLabel.text = "The winner is " + gameBoardFinal[0]
            return true
        }else if (gameBoardFinal[1] == gameBoardFinal[4]) && (gameBoardFinal[4] == gameBoardFinal[7]) && (gameBoardFinal[1] == gameBoardFinal[7]){
            self.informationLabel.text = "The winner is " + gameBoardFinal[1]
            return true
        }else if (gameBoardFinal[2] == gameBoardFinal[5]) && (gameBoardFinal[5] == gameBoardFinal[8]) && (gameBoardFinal[2] == gameBoardFinal[8]){
            self.informationLabel.text = "The winner is " + gameBoardFinal[2]
            return true
        }else if (gameBoardFinal[0] == gameBoardFinal[4]) && (gameBoardFinal[4] == gameBoardFinal[8]) && (gameBoardFinal[0] == gameBoardFinal[8]){
            self.informationLabel.text = "The winner is " + gameBoardFinal[0]
            return true
        }else if (gameBoardFinal[2] == gameBoardFinal[4]) && (gameBoardFinal[4] == gameBoardFinal[6]) && (gameBoardFinal[2] == gameBoardFinal[6]){
            self.informationLabel.text = "The winner is " + gameBoardFinal[2]
            return true
        }else{
            return false
        }
    }
    @objc func playerSlider(_ sender: UISwitch){
        if sender.isOn{
            playerLabel.text = "Player: O"
            playerTurnX = false
        }else{
            playerLabel.text = "Player: X"
            playerTurnX = true
        }
    }
    
    @objc func gameButtonClicked(_ sender: UIButton){
        if gameStarted && !isWinner{
            changeLabel(player: playerTurnX, whichButton: sender.tag)
            
            if playerTurnX{
                self.informationLabel.text = "Player O turn"
                playerTurnX = false
            }else{
                self.informationLabel.text = "Player X turn"
                playerTurnX = true
            }
            
            isWinner = decideWinner()
        }
    }
    
    @objc func startButtonClicked(_ sender: UIButton){
        self.gameStarted = true
        self.isWinner = false
        self.playerTurnX = true
        
        self.playerLabel.text = "Player: X"
        self.startButton.setTitle("Restart", for: .normal)
        self.informationLabel.text = "GAME STARTED!"
        
        self.xOrO.setOn(false, animated: true)
        
        for x in gameBoardButtons{
            x.buttonLabel = " "
            x.ticTacToeButton?.titleLabel?.text = x.buttonLabel
            x.ticTacToeButton?.setTitle("", for: .normal)
        }
    }
    
    func changeLabel(player: Bool, whichButton: Int){
        if player{
            gameBoardButtons[whichButton].buttonLabel = "X"
            gameBoardButtons[whichButton].ticTacToeButton?.setTitle(gameBoardButtons[whichButton].buttonLabel, for: .normal)
        }else{
            gameBoardButtons[whichButton].buttonLabel = "O"
            gameBoardButtons[whichButton].ticTacToeButton?.setTitle(gameBoardButtons[whichButton].buttonLabel, for: .normal)
        }
    }
    
    func gameBoardConstraints(){
        self.informationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.gameBoardView.addSubview(informationLabel)
        
        for i in gameBoardButtons{
            self.gameBoardView.addSubview(i.ticTacToeButton!)
            i.ticTacToeButton?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constratint0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button0]-[button1(==button0)]-[button2(==button0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constratint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button3]-[button4(==button0)]-[button5(==button0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constratint2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button6]-[button7(==button0)]-[button8(==button0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constratint3 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constratint4 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[button0(100)]-[button3(==button0)]-[button6(==button0)]-[label]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constratint5 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[button1(==button0)]-[button4(==button0)]-[button7(==button0)]-[label]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constratint6 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[button2(==button0)]-[button5(==button0)]-[button8(==button0)]-[label]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)

        self.gameBoardView.addConstraints(constratint0)
        self.gameBoardView.addConstraints(constratint1)
        self.gameBoardView.addConstraints(constratint2)
        self.gameBoardView.addConstraints(constratint3)
        self.gameBoardView.addConstraints(constratint4)
        self.gameBoardView.addConstraints(constratint5)
        self.gameBoardView.addConstraints(constratint6)


    }
    
    func gameScreenConstraints(){
        self.view.addSubview(xOrO)
        self.view.addSubview(gameBoardView)
        self.view.addSubview(startButton)
        self.view.addSubview(playerLabel)
        
        self.xOrO.translatesAutoresizingMaskIntoConstraints = false
        self.gameBoardView.translatesAutoresizingMaskIntoConstraints = false
        self.startButton.translatesAutoresizingMaskIntoConstraints = false
        self.playerLabel.translatesAutoresizingMaskIntoConstraints = false
               
        let constratint0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[start]-50-[switch]-50-[playerLabel(==start)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constratint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|[gameBoard]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constratint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-150-[start(50)]-50-[gameBoard]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constratint3 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-150-[switch]-50-[gameBoard]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)
        let constratint4 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-150-[playerLabel]-50-[gameBoard]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.ticTacToeDictionary)

        self.view.addConstraints(constratint0)
        self.view.addConstraints(constratint1)
        self.view.addConstraints(constratint2)
        self.view.addConstraints(constratint3)
        self.view.addConstraints(constratint4)
    }
}
