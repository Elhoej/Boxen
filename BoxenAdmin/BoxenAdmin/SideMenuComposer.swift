//
//  SideMenuComposer.swift
//  BoxenAdmin
//
//  Created by Simon Elhøj Steinmejer on 29/06/2022.
//

import UIKit

final class ContainerViewComposer {
    static func makeContainer() -> ContainerViewController {
        let homeViewController = HomeViewControllerNew()
        let profileViewController = ProfileViewController()
        let patientListViewController = PatientListViewController()
        let caretakerViewController = CaretakerViewController()
        let settingsViewController = SettingsViewController()
        let sideMenuItems = [
            SideMenuItem(icon: UIImage(named: "ico_home"),
                         name: "Home",
                         viewController: .embed(homeViewController)),
            SideMenuItem(icon: UIImage(named: "pill_menu_icon"),
                         name: "Pill",
                         viewController: .embed(patientListViewController)),
            SideMenuItem(icon: UIImage(named: "profile_menu_icon"),
                         name: "Profile",
                         viewController: .embed(profileViewController)),
            SideMenuItem(icon: UIImage(named: "caretaker_menu_icon"), name: "Caretaker", viewController: .embed(caretakerViewController)),
            SideMenuItem(icon: UIImage(named: "settings_menu_icon"),
                         name: "Settings",
                         viewController: .embed(settingsViewController))
        ]
        let sideMenuViewController = SideMenuViewController(sideMenuItems: sideMenuItems)
        let container = ContainerViewController(sideMenuViewController: sideMenuViewController,
                                                rootViewController: homeViewController)

        return container
    }
}
