//
//  CalcViewController.swift
//  Calculator
//
//  Created by Griffin Rades on 10/23/19.
//  Copyright © 2019 Saint Mary's University. All rights reserved.
//

import UIKit

class CalcViewController: UIViewController {
    
    var buttonDictionary = [String:Any]()
    var calculatorLabel = UILabel()
    var calculatorButtonsArray: [CalcButtons] = []
    var currentScreenNumber = 0.0
    var previousScreenNumber = 0.0
    var totalValue = 0.0
    var operation = ""
    /*
     MARK: loadView
     creates the entire layout of the view
     */
    override func loadView() {
        super.loadView()
        
        let buttonNumbers = ["Clear","Negate","0","1","2","3","4","5","6","7","8","9"] //Array of the number button label names including clear and negate
        let operationButtons = ["X","%","/","+","-",".","="] //Array of operation button label names
        
        //set up the calculator label
        self.calculatorLabel.text = ""
        self.calculatorLabel.textAlignment = .right
        self.calculatorLabel.backgroundColor = .white
        self.calculatorLabel.font = self.calculatorLabel.font.withSize(20)
        self.buttonDictionary["Label"] = self.calculatorLabel
        
        //create array of calculator buttons (numbers) and add them to a dictonary of the buttons Key:"String" Value:UIButton
        for i in buttonNumbers{
            let x = CalcButtons()
            
            x.buttonLabel = i
            x.title = "n" + i
            x.calculatorButton = UIButton(type: .system)
            x.calculatorButton?.setTitle(x.buttonLabel, for: .normal)
            x.calculatorButton?.backgroundColor = .gray
            x.calculatorButton?.setTitleColor(.white, for: .normal)
            x.calculatorButton?.addTarget(self, action: #selector(numberClicked), for: .touchUpInside)
            x.calculatorButton?.titleLabel?.font = self.calculatorLabel.font
            
            self.calculatorButtonsArray.append(x)
            self.buttonDictionary[x.title!] = x.calculatorButton
        }
        //create array of calculator buttons (operations) and add to them to a dictonary of the buttons Key:"String" Value:UIButton
        for i in 0..<operationButtons.count{
            let x = CalcButtons()
            
            x.buttonLabel = operationButtons[i]
            x.calculatorButton = UIButton(type: .system)
            x.calculatorButton?.setTitle(x.buttonLabel, for: .normal)
            x.calculatorButton?.backgroundColor = .gray
            x.calculatorButton?.setTitleColor(.white, for: .normal)
            x.calculatorButton?.addTarget(self, action: #selector(operationClicked), for: .touchUpInside)
            x.calculatorButton?.titleLabel?.font = self.calculatorLabel.font
            
            self.calculatorButtonsArray.append(x)
            self.buttonDictionary["SC" + String(i)] = x.calculatorButton
        }
        addButtonConstraints() //add constraints to the buttons using the button dicitonary
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }
    /*
     MARK: listener functions to listen for when a button is clicked
     */
    @objc func numberClicked(_ sender: UIButton){
        if let buttonTitle = sender.titleLabel?.text{ //unwrap the button title label
            if buttonTitle == "Clear"{ //if clear...
                self.calculatorLabel.text = ""
                self.calculatorLabel.text = ""
                self.currentScreenNumber = 0.0
                self.previousScreenNumber = 0.0
                self.totalValue = 0.0
            }else if buttonTitle == "Negate"{ //if negate...
                if self.calculatorLabel.text != ""{ //if negate and is negative already (-)(-) = +
                    if self.calculatorLabel.text?.prefix(1) == "-"{
                        self.calculatorLabel.text?.remove(at: self.calculatorLabel.text!.startIndex)
                    }else{ //make negative
                        self.calculatorLabel.text = "-" + self.calculatorLabel.text!
                    }
                }
            }else{ //if the label is a symbol the next input will me a number and remove the symbol
                if self.calculatorLabel.text == "/" || self.calculatorLabel.text == "X" || self.calculatorLabel.text == "-" || self.calculatorLabel.text == "+"{
                    self.calculatorLabel.text! = buttonTitle
                }else{ //else just append the number to the last
                    self.calculatorLabel.text! += buttonTitle
                }
            }
        }
    }
    
    @objc func operationClicked(_ sender: UIButton){
        if let buttonTitle = sender.titleLabel?.text{ //unwrap the button title label
            /*
                1: save the current screen value as a double
                2: erase the label and just put the operation symbol
                3: set operation var to the operation clicked
             */
            
            if buttonTitle == "/"{ //if divide
                previousScreenNumber = Double(self.calculatorLabel.text!)!
                self.calculatorLabel.text = "/"
                operation = "/"
            }else if buttonTitle == "X"{ //if multiply
                previousScreenNumber = Double(self.calculatorLabel.text!)!
                self.calculatorLabel.text = "X"
                operation = "X"
            }else if buttonTitle == "-"{ //if subtract
                previousScreenNumber = Double(self.calculatorLabel.text!)!
                self.calculatorLabel.text = "-"
                operation = "-"
            }else if buttonTitle == "+"{ //if add
                previousScreenNumber = Double(self.calculatorLabel.text!)!
                self.calculatorLabel.text = "+"
                operation = "+"
            }else if buttonTitle == "%"{ //if percentage skips the = and just does the calculation
                previousScreenNumber = Double(self.calculatorLabel.text!)!
                self.totalValue = previousScreenNumber / 100
                self.calculatorLabel.text = String(self.totalValue)
                operation = "%"
            }else if buttonTitle == "="{ //if equals
                /*
                    1: save the current screen text as a double
                    2: do the math accourding to the operation variable
                 */
                currentScreenNumber = Double(self.calculatorLabel.text!)!
                if operation == "/"{ //division
                    self.totalValue = self.previousScreenNumber / self.currentScreenNumber
                }else if operation == "X"{ //multiplication
                    self.totalValue = self.previousScreenNumber * self.currentScreenNumber
                }else if operation == "-"{ //subtraction
                    self.totalValue = self.previousScreenNumber - self.currentScreenNumber
                }else if operation == "+"{ //addition
                    self.totalValue = self.previousScreenNumber + self.currentScreenNumber
                }
                //set the calculator label to the value of totalValue
                self.calculatorLabel.text = String(self.totalValue)
            }
        }
    }
    /*
     MARK: addconstraints to buttons created in loadView
     */
    func addButtonConstraints(){
        view.addSubview(calculatorLabel) //add the label to the screen
        calculatorLabel.translatesAutoresizingMaskIntoConstraints = false //remove auto constraints
        
        for i in calculatorButtonsArray{
            view.addSubview(i.calculatorButton!) //add each button in the button array to the view
            i.calculatorButton!.translatesAutoresizingMaskIntoConstraints = false //remove auto constraints for each button in the button array
        }
        
        //using the button dictionary create the constraints verticaly
        let buttonConstraint_1 = NSLayoutConstraint.constraints(withVisualFormat: "V:[Label]-575-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint_2 = NSLayoutConstraint.constraints(withVisualFormat: "V:[Label(50)]-[nClear(85)]-[n7(==nClear)]-[n4(==nClear)]-[n1(==nClear)]-[n0(==nClear)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint_3 = NSLayoutConstraint.constraints(withVisualFormat: "V:[Label]-[nNegate(==nClear)]-[n8(==nClear)]-[n5(==nClear)]-[n2(==nClear)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint_4 =  NSLayoutConstraint.constraints(withVisualFormat: "V:[Label]-[SC1(==nClear)]-[n9(==nClear)]-[n6(==nClear)]-[n3(==nClear)]-[SC5(==nClear)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint_5 =  NSLayoutConstraint.constraints(withVisualFormat: "V:[Label]-[SC2(==nClear)]-[SC0(==nClear)]-[SC4(==nClear)]-[SC3(==nClear)]-[SC6(==nClear)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        
        //using the button dictions create constraints horizontally
        let buttonConstraintH_1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[Label]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[nClear(85)]-[nNegate(==nClear)]-[SC1(==nClear)]-[SC2(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_3 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[n7(==nClear)]-[n8(==nClear)]-[n9(==nClear)]-[SC0(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_4 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[n4(==nClear)]-[n5(==nClear)]-[n6(==nClear)]-[SC4(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_5 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[n1(==nClear)]-[n2(==nClear)]-[n3(==nClear)]-[SC3(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_6 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[n0(178)]-[SC5(==nClear)]-[SC6(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)


        //add each of the constaints to the view
        self.view.addConstraints(buttonConstraint_1)
        self.view.addConstraints(buttonConstraint_2)
        self.view.addConstraints(buttonConstraint_3)
        self.view.addConstraints(buttonConstraint_4)
        self.view.addConstraints(buttonConstraint_5)
        self.view.addConstraints(buttonConstraintH_1)
        self.view.addConstraints(buttonConstraintH_2)
        self.view.addConstraints(buttonConstraintH_3)
        self.view.addConstraints(buttonConstraintH_4)
        self.view.addConstraints(buttonConstraintH_5)
        self.view.addConstraints(buttonConstraintH_6)
    }
}
