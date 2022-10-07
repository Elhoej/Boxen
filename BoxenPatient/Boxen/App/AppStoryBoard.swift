//
//  AppStoryBoard.swift
//  BoldDK
//
//  Created by Simon Elhøj Steinmejer on 05/10/2020.
//  Copyright © 2020 Simon Elhøj Steinmejer. All rights reserved.
//

import Foundation
import UIKit
import MustacheUIKit

enum AppStoryboard: String {

    case main = "Main"

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func viewController<T: UIViewController>(class: T.Type) -> T {
        let storyBoardId = (`class` as UIViewController.Type).storyboardID
        guard let controller = instance.instantiateViewController(withIdentifier: storyBoardId) as? T else { fatalError() }
        return controller
    }

    var initial: UIViewController? {
        return self.instance.instantiateInitialViewController()
    }
}
