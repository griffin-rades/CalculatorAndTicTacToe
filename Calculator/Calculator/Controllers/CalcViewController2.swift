//
//  MainViewController.swift
//  Calculator
//
//  Created by Griffin Rades on 10/25/19.
//  Copyright © 2019 Saint Mary's University. All rights reserved.
//

import UIKit

class CalcViewController2: UIViewController {
    
    var buttonDictionary = [String:Any]()
    var calculatorLabel = UILabel()
    var calculatorButtonsArray: [CalcButtons] = []
    var currentScreenNumber = 0.0
    var previousScreenNumber = 0.0
    
    override func loadView() {
        super.loadView()
        
        let buttonNumbers = ["Clear","Negate","0","1","2","3","4","5","6","7","8","9"]
        let operationButtons = ["X","%","/","+","-",".","="]
        
        self.calculatorLabel.text = ""
        self.calculatorLabel.textAlignment = .right
        self.calculatorLabel.backgroundColor = .white
        self.buttonDictionary["Label"] = self.calculatorLabel
        
        for i in buttonNumbers{
            let x = CalcButtons()
            
            x.buttonLabel = i
            x.title = "n" + i
            x.calculatorButton = UIButton(type: .system)
            x.calculatorButton?.setTitle(x.buttonLabel, for: .normal)
            x.calculatorButton?.backgroundColor = .gray
            x.calculatorButton?.setTitleColor(.white, for: .normal)
            x.calculatorButton?.addTarget(self, action: #selector(numberClicked), for: .touchUpInside)
            x.calculatorButton?.titleLabel?.adjustsFontSizeToFitWidth = true
            
            self.calculatorButtonsArray.append(x)
            self.buttonDictionary[x.title!] = x.calculatorButton
        }
        for i in 0..<operationButtons.count{
            let x = CalcButtons()
            
            x.buttonLabel = operationButtons[i]
            x.calculatorButton = UIButton(type: .system)
            x.calculatorButton?.setTitle(x.buttonLabel, for: .normal)
            x.calculatorButton?.backgroundColor = .gray
            x.calculatorButton?.setTitleColor(.white, for: .normal)
            x.calculatorButton?.addTarget(self, action: #selector(operationClicked), for: .touchUpInside)
            x.calculatorButton?.titleLabel?.adjustsFontSizeToFitWidth = true
            
            self.calculatorButtonsArray.append(x)
            self.buttonDictionary["SC" + String(i)] = x.calculatorButton
        }
        addButtonConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }
    @objc func numberClicked(_ sender: UIButton){
        if let buttonTitle = sender.titleLabel?.text{
  //          print(buttonTitle)
            if buttonTitle == "Clear"{
                self.calculatorLabel.text = ""
                self.calculatorLabel.text = ""
                self.currentScreenNumber = 0.0
                self.previousScreenNumber = 0.0
            }else if buttonTitle == "Negate"{
                if self.calculatorLabel.text != ""{
                    if self.calculatorLabel.text?.prefix(1) == "-"{
                        self.calculatorLabel.text?.remove(at: self.calculatorLabel.text!.startIndex)
                    }else{
                        self.calculatorLabel.text = "-" + self.calculatorLabel.text!
                    }
                }
            }else{
                if self.calculatorLabel.text == "/" || self.calculatorLabel.text == "X" || self.calculatorLabel.text == "-" || self.calculatorLabel.text == "+"{
                    self.calculatorLabel.text! = buttonTitle
                }else{
                    self.calculatorLabel.text! += buttonTitle
                }
            }
        }
    }
    @objc func operationClicked(_ sender: UIButton){
        if let buttonTitle = sender.titleLabel?.text{
            previousScreenNumber = Double(self.calculatorLabel.text!)!
            if buttonTitle == "/"{
                self.calculatorLabel.text = "/"
            }else if buttonTitle == "X"{
                self.calculatorLabel.text = "X"
            }else if buttonTitle == "-"{
                self.calculatorLabel.text = "-"
            }else if buttonTitle == "+"{
                self.calculatorLabel.text = "+"
            }else if buttonTitle == "%"{
                self.calculatorLabel.text = "%"
            }else if buttonTitle == "="{
                if buttonTitle == "/"{
                    
                }else if buttonTitle == "X"{
                        
                }else if buttonTitle == "-"{
                        
                }else if buttonTitle == "+"{
                
                }else if buttonTitle == "%"{
                        
                }
            }
        }
    }
    func addButtonConstraints(){
        view.addSubview(calculatorLabel)
        calculatorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        for i in calculatorButtonsArray{
            view.addSubview(i.calculatorButton!)
            i.calculatorButton!.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let buttonConstraint_1 = NSLayoutConstraint.constraints(withVisualFormat: "V:[Label]-575-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint_2 = NSLayoutConstraint.constraints(withVisualFormat: "V:[Label(50)]-[nClear(85)]-[n7(==nClear)]-[n4(==nClear)]-[n1(==nClear)]-[n0(==nClear)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint_3 = NSLayoutConstraint.constraints(withVisualFormat: "V:[Label]-[nNegate(==nClear)]-[n8(==nClear)]-[n5(==nClear)]-[n2(==nClear)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttConstraint_4 =  NSLayoutConstraint.constraints(withVisualFormat: "V:[Label]-[SC1(==nClear)]-[n9(==nClear)]-[n6(==nClear)]-[n3(==nClear)]-[SC5(==nClear)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttConstraint_5 =  NSLayoutConstraint.constraints(withVisualFormat: "V:[Label]-[SC2(==nClear)]-[SC0(==nClear)]-[SC4(==nClear)]-[SC3(==nClear)]-[SC6(==nClear)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        
        let buttonConstraintH_1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[Label]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[nClear(85)]-[nNegate(==nClear)]-[SC1(==nClear)]-[SC2(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_3 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[n7(==nClear)]-[n8(==nClear)]-[n9(==nClear)]-[SC0(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_4 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[n4(==nClear)]-[n5(==nClear)]-[n6(==nClear)]-[SC4(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_5 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[n1(==nClear)]-[n2(==nClear)]-[n3(==nClear)]-[SC3(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_6 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[n0(178)]-[SC5(==nClear)]-[SC6(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)




        self.view.addConstraints(buttonConstraint_1)
        self.view.addConstraints(buttonConstraint_2)
        self.view.addConstraints(buttonConstraint_3)
        self.view.addConstraints(buttConstraint_4)
        self.view.addConstraints(buttConstraint_5)
        self.view.addConstraints(buttonConstraintH_1)
        self.view.addConstraints(buttonConstraintH_2)
        self.view.addConstraints(buttonConstraintH_3)
        self.view.addConstraints(buttonConstraintH_4)
        self.view.addConstraints(buttonConstraintH_5)
        self.view.addConstraints(buttonConstraintH_6)
    }
}
