//
//  PatientListViewController.swift
//  BoxenAdmin
//
//  Created by Simon Elhøj Steinmejer on 17/11/2021.
//

import UIKit

class PatientListViewController: ContentViewController {

    lazy var addPillButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "add_pill_icon"), for: .normal)
        button.addTarget(self, action: #selector(addPill), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
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
