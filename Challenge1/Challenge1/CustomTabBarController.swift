//
//  TabBarController.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 28/03/22.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        self.selectedIndex = 0
        print("tab bar codigo corre")
    }
    
    func setupViewControllers() {
        let firstTabTitle = "Home"
        let firstTabImage = UIImage(systemName: "house")
        let firstSelectedImage = UIImage(systemName: "house.fill")
        let secondTabTitle = "Favoritos"
        let secondTabImage = UIImage(systemName: "star")
        let secondSelectedImage = UIImage(systemName: "star.fill")
        
        let firstTab = HomeTableViewController(nibName: "HomeTableViewController", bundle: nil)
        firstTab.title = firstTabTitle
        
        let firstNavigationViewController = UINavigationController(rootViewController: firstTab)
        firstNavigationViewController.tabBarItem = UITabBarItem(title: firstTabTitle, image: firstTabImage, selectedImage: firstSelectedImage)
        
        viewControllers?.append(firstNavigationViewController)
        
        let secondTab = HomeTableViewController(nibName: "FavoritiesTableViewController", bundle: nil)
        secondTab.title = secondTabTitle
        
        let secondNavigationViewController = UINavigationController(rootViewController: secondTab)
        secondNavigationViewController.tabBarItem = UITabBarItem(title: secondTabTitle, image: secondTabImage, selectedImage: secondSelectedImage)
        
        viewControllers?.append(secondNavigationViewController)
        self.selectedIndex = 0
        
        
    }
}
