//
//  ViewController.swift
//  Calculator
//
//  Created by Griffin Rades on 10/23/19.
//  Copyright © 2019 Saint Mary's University. All rights reserved.
//

import UIKit

class CalcViewController: UIViewController {
    
    var buttonsList = [UIButton]()
    var buttonNames: [[String]] = [["Clear","Negate","%","/"],
                                   ["7","8","9","X"],
                                   ["4","5","6","-"],
                                   ["1","2","3","+"],
                                   ["0",".","="]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createButtonList()
        addButtonsToScreen()
        view.backgroundColor = .blue
    }
    
    func createButtonList(){
        for k in 0..<buttonNames.count{
            for x in 0..<buttonNames[k].count{
                var currentButton = UIButton()
                currentButton = createButtons(buttonTitle: buttonNames[k][x])
                
                buttonsList.append(currentButton)
            }
        }
    }
    
    func addButtonsToScreen(){
        var offsetXR1 = CGFloat(20)
        var offsetXR2 = CGFloat(20)
        var offsetXR3 = CGFloat(20)
        var offsetXR4 = CGFloat(20)
        var offsetXR5 = CGFloat(20)
        var offsetY = CGFloat(400)
        for k in 0..<buttonsList.count{
            if k < 4{
                view.addSubview(buttonsList[k])
                setButtonContraints(button: buttonsList[k], leadingConstant: offsetXR1, heightConsant: offsetY)
                offsetXR1 += 100
            }else if k >= 4 && k < 8{
                offsetY = 470
                view.addSubview(buttonsList[k])
                setButtonContraints(button: buttonsList[k], leadingConstant: offsetXR2, heightConsant: offsetY)
                offsetXR2 += 100
            }else if k >= 8 && k < 12{
                offsetY = 540
                view.addSubview(buttonsList[k])
                setButtonContraints(button: buttonsList[k], leadingConstant: offsetXR3, heightConsant: offsetY)
                offsetXR3 += 100
            } else if k >= 12 && k < 16{
                offsetY = 610
                view.addSubview(buttonsList[k])
                setButtonContraints(button: buttonsList[k], leadingConstant: offsetXR4, heightConsant: offsetY)
                offsetXR4 += 100
            } else{
                offsetY = 680
                view.addSubview(buttonsList[k])
                setButtonContraints(button: buttonsList[k], leadingConstant: offsetXR5, heightConsant: offsetY)
                offsetXR5 += 100
            }
        }
    }
    
    func createButtons(buttonTitle: String) -> UIButton{
        let createdButton = UIButton()
          
        createdButton.setTitle(" " + buttonTitle + " ", for: .normal)
        createdButton.backgroundColor = .black
        return createdButton
    }
    
    func setButtonContraints(button: UIButton, leadingConstant: CGFloat, heightConsant: CGFloat){
        if buttonsList[18] != button{
                button.translatesAutoresizingMaskIntoConstraints = false
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingConstant).isActive = true
                button.widthAnchor.constraint(equalToConstant: 80).isActive = true
                button.heightAnchor.constraint(equalToConstant: 50).isActive = true
                button.topAnchor.constraint(equalTo: view.topAnchor, constant: heightConsant).isActive = true
        }else{
                button.translatesAutoresizingMaskIntoConstraints = false
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingConstant).isActive = true
                button.widthAnchor.constraint(equalToConstant: 180).isActive = true
                button.heightAnchor.constraint(equalToConstant: 50).isActive = true
                button.topAnchor.constraint(equalTo: view.topAnchor, constant: heightConsant).isActive = true
        }
    }
}
