//
//  AppDelegate.swift
//  Boxen
//
//  Created by Simon Elhøj Steinmejer on 07/10/2020.
//

import UIKit
import IQKeyboardManagerSwift
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.configureParse()

        self.window = UIWindow()
        window?.makeKeyAndVisible()

//        window?.rootViewController = PilleViewController()
        if let _ = PFUser.current() {
            window?.rootViewController = PilleViewController()
        } else {
            window?.rootViewController = SignInViewController()
        }

        IQKeyboardManager.shared.enable = true
        
        self.requestNotificationAccess()
        
        return true
    }

    func configureParse() {
        User.registerSubclass()
        Pill.registerSubclass()
        PillConsumption.registerSubclass()

        let configuration = ParseClientConfiguration {
          $0.applicationId = "Iqun5VYYfEpZiw0XqkerR8YpQ1yKrImdtPImufrq"
          $0.clientKey = "A080nQNZZYMr2iesR0qGHMZ0oNA1jNHjwkvC1wEG"
          $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: configuration)
    }
    
    func requestNotificationAccess() {
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let options: UNAuthorizationOptions = [.alert, .sound]
            
            notificationCenter.requestAuthorization(options: options) {
                (didAllow, error) in
                if !didAllow {
                    print("User has declined notifications")
                }
            }
        
    }


}

