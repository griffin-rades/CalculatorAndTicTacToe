//
//  ViewController.swift
//  Calculator
//
//  Created by Griffin Rades on 10/23/19.
//  Copyright © 2019 Saint Mary's University. All rights reserved.
//

import UIKit

class CalcViewController: UIViewController {
    
    var buttonsList: [[UIButton]] = [[UIButton]]()
    var buttonNames: [[String]] = [["Clear","Negate","%","/"],
                                   ["7","8","9","X"],
                                   ["4","5","6","-"],
                                   ["1","2","3","+"],
                                   ["0",".","="]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpScreen()
        view.backgroundColor = .blue
    }
    
    func setUpScreen(){
        for k in 0..<buttonNames.count{
            for x in 0..<buttonNames[k].count{
                var currentButton = UIButton()
                currentButton = createButtons(buttonTitle: buttonNames[k][x])
                
                buttonsList.append([currentButton])
                
                addButtonsToScreen(button: buttonsList[k][x])
            }
        }
    }
    
    func addButtonsToScreen(button: UIButton){
        view.addSubview(button)
        setButtonContraints(button: button, offset: 20)
    }
    
    func createButtons(buttonTitle: String) -> UIButton{
        let createdButton = UIButton()
          
        createdButton.setTitle(" " + buttonTitle + " ", for: .normal)
        createdButton.backgroundColor = .black
        return createdButton
    }
    
    func setButtonContraints(button: UIButton, offset: CGFloat){
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(offset)).isActive = true
        //button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat(-offset)).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}



//Testing button creation and loactions.
//    func createButton(){
//        button = UIButton()
//        button.setTitleColor(.red, for: .normal)
//        button.backgroundColor = .white
//        button.setTitle(" " + buttonNames[0][0] + " ", for: .normal)
//
//        view.addSubview(button)
//        setButtonContraints()
//    }
//
//    func setButtonContraints(){
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(distance)).isActive = true
//        //button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//
//    }
//    func printArray(){
//        for var k in 0..<buttonNames.count{
//            for var x in 0..<buttonNames[k].count{
//                print(buttonNames[k][x])
//            }
//        }
//    }


