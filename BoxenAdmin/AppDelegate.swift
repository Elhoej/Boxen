//
//  AppDelegate.swift
//  BoxenAdmin
//
//  Created by Simon Elhøj Steinmejer on 28/10/2021.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.configureParse()

        self.window = UIWindow()
        if let _ = PFUser.current() {
            let sideMenu = ContainerViewComposer.makeContainer()
            window?.rootViewController = sideMenu
        } else {
            window?.rootViewController = SignInViewController()
        }
        self.window?.makeKeyAndVisible()

        return true
    }

    func configureParse() {
        User.registerSubclass()
        Pill.registerSubclass()
        PillConsumption.registerSubclass()
        PatientRelation.registerSubclass()

        let configuration = ParseClientConfiguration {
          $0.applicationId = "Iqun5VYYfEpZiw0XqkerR8YpQ1yKrImdtPImufrq"
          $0.clientKey = "A080nQNZZYMr2iesR0qGHMZ0oNA1jNHjwkvC1wEG"
          $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: configuration)
    }
}
