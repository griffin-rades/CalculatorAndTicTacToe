//
//  ViewController.swift
//  Calculator
//
//  Created by Griffin Rades on 10/23/19.
//  Copyright © 2019 Saint Mary's University. All rights reserved.
//

import UIKit

class CalcViewController: UIViewController {
    var distance = 20
    var button:UIButton!
    var buttonNames: [[String]] = [["Clear","Negate","%","/"],
                                   ["7","8","9","X"],
                                   ["4","5","6","-"],
                                   ["1","2","3","+"],
                                   ["0",".","="]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        createButton()
        distance = 80
        createButton()
        //printArray()
    }
    
    
    func createButton(){
        button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        button.setTitle(" " + buttonNames[0][0] + " ", for: .normal)
        
        view.addSubview(button)
        setButtonContraints()
    }
    
    func setButtonContraints(){
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(distance)).isActive = true
        //button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
    
//    func printArray(){
//        for var k in 0..<buttonNames.count{
//            for var x in 0..<buttonNames[k].count{
//                print(buttonNames[k][x])
//            }
//        }
//    }
}

