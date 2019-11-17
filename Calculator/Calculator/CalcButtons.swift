//
//  CalcButtons.swift
//  Calculator
//
//  Created by Griffin Rades on 10/29/19.
//  Copyright © 2019 Saint Mary's University. All rights reserved.
//

import Foundation
import UIKit

class CalcButtons: NSObject{
    var buttonLabel:String?
    var title:String?
    var calculatorButton:UIButton?
    
    override init(){
        super.init()
    }
    func changeFontSize(landscape: Bool){
        if !landscape{
            self.calculatorButton?.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        }
        else{
            self.calculatorButton?.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        }
    }
}
