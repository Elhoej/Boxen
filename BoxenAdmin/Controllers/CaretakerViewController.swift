//
//  CaretakerViewController.swift
//  BoxenAdmin
//
//  Created by Simon Elhøj Steinmejer on 03/07/2022.
//

import UIKit

class CaretakerViewController: ContentViewController {

    lazy var addPillButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "add_pill_icon"), for: .normal)
        button.addTarget(self, action: #selector(addPill), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        self.configureAutoLayout()
    }

    @objc fileprivate func addPill() {
        let controller = CreatePillViewController()
        self.delegate?.itemSelected(item: .modal(controller))
    }

    fileprivate func configureAutoLayout() {
        self.view.addSubview(self.addPillButton, anchors: [
            .bottom(to: self.view.bottomAnchor, constant: -80),
            .trailing(to: self.view.trailingAnchor, constant: 16),
            .height(constant: 60),
            .width(constant: 60)
        ])
    }

}
