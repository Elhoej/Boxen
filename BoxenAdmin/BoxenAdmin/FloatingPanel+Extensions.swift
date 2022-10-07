//
// Created by Tommy Sadiq Hinrichsen on 05/10/2021.
// Copyright (c) 2021 Dagrofa. All rights reserved.
//

import Foundation
import UIKit
import MustacheUIKit
import FloatingPanel

extension FloatingPanelControllerDelegate where Self: UIViewController {

}

extension UIViewController {

    func set(panel: FloatingPanelController?, isRemovalInteractionEnabled: Bool = true, panGestureRecognizerIsEnabled: Bool = true, action: Selector? = nil) {

        if let delegate = self as? FloatingPanelControllerDelegate {
            panel?.delegate = delegate
        }

        if let layout = self as? FloatingPanelLayout {
            panel?.layout = layout
        }

        if let scrollView = self.view.subViews(type: UIScrollView.self).first {
            panel?.track(scrollView: scrollView)
        }

        panel?.set(contentViewController: self)
        panel?.isRemovalInteractionEnabled = isRemovalInteractionEnabled

        panel?.surfaceView.grabberHandlePadding = 15
        panel?.surfaceView.grabberHandle.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        panel?.surfaceView.appearance.backgroundColor = .white
        panel?.surfaceView.appearance.cornerRadius = 25
        panel?.surfaceView.backgroundColor = .white
        panel?.surfaceView.contentPadding = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)
        panel?.panGestureRecognizer.isEnabled = panGestureRecognizerIsEnabled

        if let action = action {
            panel?.backdropView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: action))
        }

    }
}
