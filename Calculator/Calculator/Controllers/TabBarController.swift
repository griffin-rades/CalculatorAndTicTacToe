//
//  TabBarController.swift
//  Calculator
//
//  Created by Griffin Rades on 10/25/19.
//  Copyright © 2019 Saint Mary's University. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    private let CalculatorView = CalcViewController()
    private let OtherView = MainViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
        viewControllers = [createController(title: "Calculator", imageName: "calculator", vc: CalculatorView), createController(title: "No", imageName: "delete", vc: OtherView)]
        
    }
    private func createController(title: String, imageName: String, vc: UIViewController) -> UINavigationController{
        let recentView = UINavigationController(rootViewController: vc)
        recentView.tabBarItem.title = title
        recentView.tabBarItem.image = UIImage(named: imageName)
        return recentView
        
    }
}
