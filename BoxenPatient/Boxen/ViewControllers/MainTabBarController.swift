//
//  TabBarController.swift
//  Boxen
//
//  Created by Simon Elhøj Steinmejer on 07/10/2020.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.tintColor = .black
        
        let pilleController = AppStoryboard.main.viewController(class: PilleViewController.self)
        let pilleNavController = UINavigationController(rootViewController: pilleController)
        pilleNavController.navigationBar.tintColor = .pilleGreen
        
        let createViewController = AppStoryboard.main.viewController(class: CreatePillViewController.self)
        
        let settingsController = AppStoryboard.main.viewController(class: SettingsViewController.self)
        let settingsNavController = UINavigationController(rootViewController: settingsController)
        
        self.viewControllers = [pilleNavController, createViewController, settingsNavController]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is CreatePillViewController {
            
            let createPillViewController = AppStoryboard.main.viewController(class: CreatePillViewController.self)
            let createNavController = UINavigationController(rootViewController: createPillViewController)
            self.present(createNavController, animated: true, completion: nil)
            
            return false
        }
        return true
    }
}

