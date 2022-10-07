//
//  ProfileViewController.swift
//  BoxenAdmin
//
//  Created by Simon Elhøj Steinmejer on 17/11/2021.
//

import UIKit
//import FloatingPanel

class ProfileViewController: ContentViewController {

    lazy var addPillButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "add_pill_icon"), for: .normal)
        button.addTarget(self, action: #selector(addPill), for: .touchUpInside)
        return button
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureAutoLayout()
        self.configureView()
    }

    @objc fileprivate func addPill() {
        let controller = CreatePillViewController()
        self.delegate?.itemSelected(item: .modal(controller))
    }

    override func configureView() {
        self.view.backgroundColor = .white
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
