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
    private let calculatorView = CalcViewController()
    private let nextProject = NextProject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let viewOne = createController(title: "Calculator", imageName: "calculator", vc: self.calculatorView)
        let viewTwo = createController(title: "Next", imageName: "delete", vc: self.nextProject)
        
        viewControllers = [viewOne, viewTwo]
        
    }
    
    private func createController(title: String, imageName: String, vc: UIViewController) -> UINavigationController{
        let recentView = UINavigationController(rootViewController: vc)
        recentView.tabBarItem.title = title
        recentView.tabBarItem.image = UIImage(named: imageName)
        
        return recentView
    }
}
