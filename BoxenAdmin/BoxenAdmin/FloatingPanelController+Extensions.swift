//
// Created by Tommy Sadiq Hinrichsen on 08/10/2021.
// Copyright (c) 2021 Dagrofa. All rights reserved.
//

import Foundation
import UIKit
import FloatingPanel

extension FloatingPanelController {

    convenience init(controller: UIViewController, isRemovalInteractionEnabled: Bool = true, panGestureRecognizerIsEnabled: Bool = true, action: Selector? = nil) {
        self.init()

        if let delegate = controller as? FloatingPanelControllerDelegate {
            self.delegate = delegate
        }

        if let layout = controller as? FloatingPanelLayout {
            self.layout = layout
        }

        self.set(contentViewController: controller)
        self.isRemovalInteractionEnabled = isRemovalInteractionEnabled

        self.surfaceView.grabberHandlePadding = 15
        self.surfaceView.grabberHandle.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.surfaceView.appearance.backgroundColor = .white
        self.surfaceView.appearance.cornerRadius = 25
        self.surfaceView.backgroundColor = .white
        self.surfaceView.contentPadding = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)
        self.panGestureRecognizer.isEnabled = panGestureRecognizerIsEnabled

        if let action = action {
            self.backdropView.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: action))
        }
    }
}
