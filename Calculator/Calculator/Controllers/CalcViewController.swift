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
    var extraCalculatorButtons: [CalcButtons] = []
    var currentScreenNumber = 0.0
    var previousScreenNumber = 0.0
    var totalValue = 0.0
    var operation = ""
    let mainButtonView = UIView()
    let extraButtonsView = UIView()
    var viewDictionary = [String:Any]()
    
    /*
     MARK: loadView
     creates the entire layout of the view
     */
    override func loadView() {
        super.loadView()
        
        let buttonNumbers = ["Clear","0","1","2","3","4","5","6","7","8","9"] //Array of the number button label names including clear and negate
        let operationButtons = ["X","%","/","+","-",".","=","+/-"] //Array of operation button label names
        let landScapeButtons = ["(",")","mc","m+","m-","mr","2nd","x^2","x^3","x^y","e^x","2^x","1/x","sqrtX","crtX","YrtX","ln","log","x!","sin","cos","tan","e","EE","Rad","sinh","cosh","tanh","pi","Rans"]
        
        //set up the calculator label
        self.calculatorLabel.backgroundColor = .white
        self.calculatorLabel.text = ""
        self.calculatorLabel.textAlignment = .right
        self.calculatorLabel.font = self.calculatorLabel.font.withSize(40)
        
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
            x.calculatorButton?.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            
            if x.calculatorButton?.titleLabel?.text == "Clear"{
                x.calculatorButton?.backgroundColor = .blue
            }
            
            self.calculatorButtonsArray.append(x)
            self.buttonDictionary[x.title!] = x.calculatorButton
        }
        //create array of calculator buttons (operations) and add to them to a dictonary of the buttons Key:"String" Value:UIButton
        for i in 0..<operationButtons.count{
            let x = CalcButtons()
            
            x.buttonLabel = operationButtons[i]
            x.calculatorButton = UIButton(type: .system)
            x.calculatorButton?.setTitle(x.buttonLabel, for: .normal)
            x.calculatorButton?.backgroundColor = .red
            x.calculatorButton?.setTitleColor(.white, for: .normal)
            x.calculatorButton?.addTarget(self, action: #selector(operationClicked), for: .touchUpInside)
            x.calculatorButton?.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            
            self.calculatorButtonsArray.append(x)
            self.buttonDictionary["SC" + String(i)] = x.calculatorButton
        }
        for i in 0..<landScapeButtons.count{
            let x = CalcButtons()
            
            x.buttonLabel = landScapeButtons[i]
            x.calculatorButton = UIButton(type: .system)
            x.calculatorButton?.setTitle(x.buttonLabel, for: .normal)
            x.calculatorButton?.backgroundColor = .gray
            x.calculatorButton?.setTitleColor(.white, for: .normal)
            x.calculatorButton?.addTarget(self, action: #selector(operationClicked), for: .touchUpInside)
            x.calculatorButton?.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            
            self.extraCalculatorButtons.append(x)
            self.buttonDictionary["EB" + String(i)] = x.calculatorButton
        }
        createMainButtonView(isPortrait: true)
//        addStandardButtonConstraints() //add constraints to the buttons using the button dicitonary
//        addExtraButtonConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            createMainButtonView(isPortrait: false)
        } else {
            createMainButtonView(isPortrait: true)
        }
    }

    /*
     MARK: listener functions to listen for when a button is clicked
     */
    @objc func numberClicked(_ sender: UIButton){
        if let buttonTitle = sender.titleLabel?.text{ //unwrap the button title label
            if buttonTitle == "Clear"{ //if clear...
                self.calculatorLabel.text = ""
                self.currentScreenNumber = 0.0
                self.previousScreenNumber = 0.0
                self.totalValue = 0.0
            }else{ //if the label is a symbol the next input will me a number and remove the symbol
                if self.calculatorLabel.text == "/" || self.calculatorLabel.text == "X" || self.calculatorLabel.text == "-" || self.calculatorLabel.text == "+" || self.calculatorLabel.text == "^" || self.calculatorLabel.text == "2^" || self.calculatorLabel.text == "1/" || self.calculatorLabel.text == "root"{
                    self.calculatorLabel.text! = buttonTitle
                }else{ //else just append the number to the last
                    self.calculatorLabel.text! += buttonTitle
                }
            }
        }
    }
    
    @objc func operationClicked(_ sender: UIButton){
        if let buttonTitle = sender.titleLabel?.text{ //unwrap the button title label
            var flag = false //used to see if divide by 0
            /*
                1: save the current screen value as a double
                2: erase the label and just put the operation symbol
                3: set operation var to the operation clicked
             */
            if buttonTitle == "+/-"{ //if negate...
                if self.calculatorLabel.text != ""{ //if negate and is negative already (-)(-) = +
                    if self.calculatorLabel.text?.prefix(1) == "-"{
                        self.calculatorLabel.text?.remove(at: self.calculatorLabel.text!.startIndex)
                    }else{ //make negative
                        self.calculatorLabel.text = "-" + self.calculatorLabel.text!
                    }
                }
            }
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
            }else if buttonTitle == "x^2"{
                previousScreenNumber = Double(self.calculatorLabel.text!)!
                self.totalValue = previousScreenNumber * previousScreenNumber
                self.calculatorLabel.text = String(self.totalValue)
                operation = "square"
            }else if buttonTitle == "x^3"{
                previousScreenNumber = Double(self.calculatorLabel.text!)!
                self.totalValue = previousScreenNumber * previousScreenNumber * previousScreenNumber
                self.calculatorLabel.text = String(self.totalValue)
                operation = "cube"
            }else if buttonTitle == "x^y"{
                previousScreenNumber = Double(self.calculatorLabel.text!)!
                self.calculatorLabel.text = "^"
                operation = "power"
            }else if buttonTitle == "2^x"{
                previousScreenNumber = Double(2.0)
                self.calculatorLabel.text = "2^"
                operation = "twoPower"
            }else if buttonTitle == "1/x"{
                previousScreenNumber = Double(1.0)
                self.calculatorLabel.text = "1/"
                operation = "oneOver"
            }else if buttonTitle == "pi"{
                self.calculatorLabel.text = "3.14159265359"
            }else if buttonTitle == "sqrtX"{
                if  self.calculatorLabel.text != nil {
                    previousScreenNumber = Double(self.calculatorLabel.text!)!
                    if previousScreenNumber > 0.0{
                        self.totalValue = sqrt(previousScreenNumber)
                        self.calculatorLabel.text = String(self.totalValue)
                    }
                }
            }else if buttonTitle == "crtX"{
                previousScreenNumber = Double(self.calculatorLabel.text!)!
                self.totalValue = pow(self.previousScreenNumber, 1/3)
                self.calculatorLabel.text = String(self.totalValue)
                
            }else if buttonTitle == "YrtX"{
                previousScreenNumber = Double(self.calculatorLabel.text!)!
                self.calculatorLabel.text = "root"
                operation = "root"
            }else if buttonTitle == "="{ //if equals
                /*
                    1: save the current screen text as a double
                    2: do the math accourding to the operation variable
                 */
                currentScreenNumber = Double(self.calculatorLabel.text!)!
                if operation == "/"{ //division
                    if self.currentScreenNumber > 0{
                        self.totalValue = self.previousScreenNumber / self.currentScreenNumber
                    }else{
                        flag = true
                    }
                }else if operation == "X"{ //multiplication
                    self.totalValue = self.previousScreenNumber * self.currentScreenNumber
                }else if operation == "-"{ //subtraction
                    self.totalValue = self.previousScreenNumber - self.currentScreenNumber
                }else if operation == "+"{ //addition
                    self.totalValue = self.previousScreenNumber + self.currentScreenNumber
                }else if operation == "power"{
                    self.totalValue = pow(self.previousScreenNumber, self.currentScreenNumber)
                }else if operation == "twoPower"{
                    self.totalValue = pow(self.previousScreenNumber, self.currentScreenNumber)
                }else if operation == "oneOver"{
                    self.totalValue = self.previousScreenNumber / self.currentScreenNumber
                }else if operation == "root"{
                    self.totalValue = pow(self.previousScreenNumber, 1/self.currentScreenNumber)
                }
            //set the calculator label to the value of totalValue
                if flag {
                    self.calculatorLabel.text = "Divide by 0 Error"
                }else{
                    self.calculatorLabel.text = String(self.totalValue)
                }
            
            }else if buttonTitle == "."{ //if decimal point clicked
                if (self.calculatorLabel.text?.contains("."))!{ //if the label alread is a decimal do nothing
                    
                }else{ //add a decimal point
                    self.calculatorLabel.text! += "."
                }
            }
        }
    }
    /*
     MARK: Create the view to contain the sets of buttons.
     */
    func createMainButtonView(isPortrait:Bool){
        self.view.addSubview(self.calculatorLabel) //add the label to the screen
        self.view.addSubview(self.extraButtonsView)
        
        self.calculatorLabel.translatesAutoresizingMaskIntoConstraints = false //remove auto constraints
        self.mainButtonView.translatesAutoresizingMaskIntoConstraints = false
        self.extraButtonsView.translatesAutoresizingMaskIntoConstraints = false
        
        self.mainButtonView.backgroundColor = .black
        self.extraButtonsView.backgroundColor = .black
        self.viewDictionary["buttonView"] = self.mainButtonView
        self.viewDictionary["label"] = self.calculatorLabel
        self.viewDictionary["otherButtons"]  = self.extraButtonsView
        
//        let pViewConstraint0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[label]-5-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.viewDictionary)
//        let pViewConstraint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|[buttonView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.viewDictionary)
//        let pViewConstraint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label(200)]-0-[buttonView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.viewDictionary)

//        let lViewConstraint0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[label]-5-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.viewDictionary)
//        let lViewConstraint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|[otherButtons(200)]-0-[buttonView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.viewDictionary)
//        let lViewConstraint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label]-0-[otherButtons]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.viewDictionary)

        if isPortrait{
            self.mainButtonView.removeFromSuperview()
            self.extraButtonsView.removeFromSuperview()
            
            for x in calculatorButtonsArray{
                x.changeFontSize(landscape: false)
            }
            
            self.view.addSubview(self.mainButtonView)
            let pViewConstraint0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[label]-5-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.viewDictionary)
            let pViewConstraint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|[buttonView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.viewDictionary)
            let pViewConstraint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label(100)]-0-[buttonView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.viewDictionary)
            
            self.view.addConstraints(pViewConstraint0)
            self.view.addConstraints(pViewConstraint1)
            self.view.addConstraints(pViewConstraint2)
            
            addStandardButtonConstraints()
        }else{
            self.mainButtonView.removeFromSuperview()
            self.view.addSubview(self.mainButtonView)
            self.view.addSubview(self.extraButtonsView)
            
            for x in calculatorButtonsArray{
                x.changeFontSize(landscape: true)
            }
            
            let lViewConstraint0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[label]-5-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.viewDictionary)
            let lViewConstraint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|[otherButtons(==buttonView)]-0-[buttonView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.viewDictionary)
            let lViewConstraint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label]-0-[otherButtons]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.viewDictionary)
            let lViewConstraint3 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label]-0-[buttonView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.viewDictionary)

            self.view.addConstraints(lViewConstraint0)
            self.view.addConstraints(lViewConstraint1)
            self.view.addConstraints(lViewConstraint2)
            self.view.addConstraints(lViewConstraint3)
            
            addStandardButtonConstraints()
            addExtraButtonConstraints()
        }
    }
    /*
     MARK: Standard buttons constrained within mainButtonView
     */
    func addStandardButtonConstraints(){
        for i in calculatorButtonsArray{
            self.mainButtonView.addSubview(i.calculatorButton!) //add each button in the button array to the view
            i.calculatorButton!.translatesAutoresizingMaskIntoConstraints = false //remove auto constraints for each button in the button array
        }
        
        //using the button dictionary create the constraints verticaly
        //let buttonConstraint_1 = NSLayoutConstraint.constraints(withVisualFormat: "V:[Label]-575-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint_2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[nClear]-[n7(==nClear)]-[n4(==nClear)]-[n1(==nClear)]-[n0(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint_3 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[SC7(==nClear)]-[n8(==nClear)]-[n5(==nClear)]-[n2(==nClear)]-[n0(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint_4 =  NSLayoutConstraint.constraints(withVisualFormat: "V:|-[SC1(==nClear)]-[n9(==nClear)]-[n6(==nClear)]-[n3(==nClear)]-[SC5(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint_5 =  NSLayoutConstraint.constraints(withVisualFormat: "V:|-[SC2(==nClear)]-[SC0(==nClear)]-[SC4(==nClear)]-[SC3(==nClear)]-[SC6(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        
        //using the button dictions create constraints horizontally
        //let buttonConstraintH_1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[Label]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[nClear]-[SC7(==nClear)]-[SC1(==nClear)]-[SC2(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_3 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[n7(==nClear)]-[n8(==nClear)]-[n9(==nClear)]-[SC0(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_4 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[n4(==nClear)]-[n5(==nClear)]-[n6(==nClear)]-[SC4(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_5 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[n1(==nClear)]-[n2(==nClear)]-[n3(==nClear)]-[SC3(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH_6 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[n0]-[SC5(==nClear)]-[SC6(==nClear)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)


        //add each of the constaints to the mainButtonView
        //self.view.addConstraints(buttonConstraint_1)
        self.mainButtonView.addConstraints(buttonConstraint_2)
        self.mainButtonView.addConstraints(buttonConstraint_3)
        self.mainButtonView.addConstraints(buttonConstraint_4)
        self.mainButtonView.addConstraints(buttonConstraint_5)
        //self.view.addConstraints(buttonConstraintH_1)
        self.mainButtonView.addConstraints(buttonConstraintH_2)
        self.mainButtonView.addConstraints(buttonConstraintH_3)
        self.mainButtonView.addConstraints(buttonConstraintH_4)
        self.mainButtonView.addConstraints(buttonConstraintH_5)
        self.mainButtonView.addConstraints(buttonConstraintH_6)
    }
    func addExtraButtonConstraints(){
        for i in extraCalculatorButtons{
            self.extraButtonsView.addSubview(i.calculatorButton!) //add each button in the button array to the view
            i.calculatorButton!.translatesAutoresizingMaskIntoConstraints = false //remove auto constraints for each button in the button array
        }
        
        let buttonConstraint0 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[EB0]-[EB6(==EB0)]-[EB12(==EB0)]-[EB18(==EB0)]-[EB24(==EB0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[EB1(==EB0)]-[EB7(==EB0)]-[EB13(==EB0)]-[EB19(==EB0)]-[EB25(==EB0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[EB2(==EB0)]-[EB8(==EB0)]-[EB14(==EB0)]-[EB20(==EB0)]-[EB26(==EB0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint3 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[EB3(==EB0)]-[EB9(==EB0)]-[EB15(==EB0)]-[EB21(==EB0)]-[EB27(==EB0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint4 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[EB4(==EB0)]-[EB10(==EB0)]-[EB16(==EB0)]-[EB22(==EB0)]-[EB28(==EB0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraint5 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[EB5(==EB0)]-[EB11(==EB0)]-[EB17(==EB0)]-[EB23(==EB0)]-[EB29(==EB0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)

        let buttonConstraintH0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[EB0]-[EB1(==EB0)]-[EB2(==EB0)]-[EB3(==EB0)]-[EB4(==EB0)]-[EB5(==EB0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[EB6(==EB0)]-[EB7(==EB0)]-[EB8(==EB0)]-[EB9(==EB0)]-[EB10(==EB0)]-[EB11(==EB0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[EB12(==EB0)]-[EB13(==EB0)]-[EB14(==EB0)]-[EB15(==EB0)]-[EB16(==EB0)]-[EB17(==EB0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH3 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[EB18(==EB0)]-[EB19(==EB0)]-[EB20(==EB0)]-[EB21(==EB0)]-[EB22(==EB0)]-[EB23(==EB0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)
        let buttonConstraintH4 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[EB24(==EB0)]-[EB25(==EB0)]-[EB26(==EB0)]-[EB27(==EB0)]-[EB28(==EB0)]-[EB29(==EB0)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: self.buttonDictionary)

        self.extraButtonsView.addConstraints(buttonConstraint0)
        self.extraButtonsView.addConstraints(buttonConstraint1)
        self.extraButtonsView.addConstraints(buttonConstraint2)
        self.extraButtonsView.addConstraints(buttonConstraint3)
        self.extraButtonsView.addConstraints(buttonConstraint4)
        self.extraButtonsView.addConstraints(buttonConstraint5)
        self.extraButtonsView.addConstraints(buttonConstraintH0)
        self.extraButtonsView.addConstraints(buttonConstraintH1)
        self.extraButtonsView.addConstraints(buttonConstraintH2)
        self.extraButtonsView.addConstraints(buttonConstraintH3)
        self.extraButtonsView.addConstraints(buttonConstraintH4)
    }
}
