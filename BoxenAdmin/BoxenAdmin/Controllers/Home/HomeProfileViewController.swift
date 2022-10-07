//
//  HomeProfileViewController.swift
//  BoxenAdmin
//
//  Created by Simon Elhøj Steinmejer on 05/07/2022.
//

import UIKit
import FloatingPanel

class HomeProfileViewController: UIViewController {

    lazy var uploadImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload Image", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 100/255, green: 115/255, blue: 140/255, alpha: 1)
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
        return button
    }()

    lazy var callButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Call caretaker ☎️", for: .normal)
        button.setTitleColor(UIColor(red: 50/255, green: 75/255, blue: 78/255, alpha: 1), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1).cgColor
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(call), for: .touchUpInside)
        return button
    }()

    lazy var holidayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("I'm on holiday 🏝", for: .normal)
        button.setTitleColor(UIColor(red: 50/255, green: 75/255, blue: 78/255, alpha: 1), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1).cgColor
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(holiday), for: .touchUpInside)
        return button
    }()

    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(UIColor(red: 50/255, green: 75/255, blue: 78/255, alpha: 1), for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    @objc fileprivate func uploadImage() {

    }

    @objc fileprivate func call() {

    }

    @objc fileprivate func holiday() {

    }

    @objc func close(_ sender: Any) {
        self.dismiss(animated: true)
    }

    fileprivate func configureView() {
        let stackView = UIStackView(arrangedSubviews: [self.uploadImageButton, self.callButton, self.holidayButton, self.dismissButton])
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.distribution = .fillEqually

        self.view.addSubview(stackView, anchors: [
            .top(to: self.view.topAnchor, constant: 30),
            .leading(to: self.view.leadingAnchor, constant: 45),
            .trailing(to: self.view.trailingAnchor, constant: 45),
            .height(constant: 228)
        ])
    }
}

extension HomeProfileViewController: FloatingPanelLayout {

    var position: FloatingPanelPosition { .bottom }

    var initialState: FloatingPanelState { .tip }

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 290, edge: .bottom, referenceGuide: .superview)
        ]
    }

    func backdropAlpha(for state: FloatingPanelState) -> CGFloat { return 0.7 }

}
