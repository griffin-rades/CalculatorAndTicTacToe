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
    var startButton = UIButton()
    var gameBoardButtons: [ticTacToeButtons] = []
    var ticTacToeDictionary = [String: Any]()
    
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
            x.ticTacToeButon = UIButton(type: .system)
            x.ticTacToeButon?.setTitle("", for: .normal)
            x.ticTacToeButon?.backgroundColor = .white
            x.ticTacToeButon?.setTitleColor(.black, for: .normal)
            x.ticTacToeButon?.addTarget(self, action: #selector(gameButtonClicked), for: .touchUpInside)
            self.ticTacToeDictionary[x.title!] = x.ticTacToeButon
            self.gameBoardButtons.append(x)
        }
    }
    
    @objc func gameButtonClicked(){
        print("game button clicked")
    }
    @objc func startButtonClicked(){
        print("start button clicked")
    }
    
    func gameBoardConstraints(){
        self.informationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.gameBoardView.addSubview(informationLabel)
        
        for i in gameBoardButtons{
            self.gameBoardView.addSubview(i.ticTacToeButon!)
            i.ticTacToeButon?.translatesAutoresizingMaskIntoConstraints = false
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
