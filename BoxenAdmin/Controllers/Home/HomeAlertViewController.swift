//
//  HomeAlertViewController.swift
//  BoxenAdmin
//
//  Created by Simon Elhøj Steinmejer on 03/07/2022.
//

import UIKit
import FloatingPanel

class HomeAlertView: UIView {

    let alertImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 50/255, green: 75/255, blue: 78/255, alpha: 1)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }

    fileprivate func configureView() {
        self.layer.borderColor = UIColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1).cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true

        self.addSubview(self.alertImageView, anchors: [
            .top(to: self.topAnchor, constant: 20),
            .centerX(to: self.centerXAnchor),
            .height(constant: 42),
            .width(constant: 42)
        ])

        self.addSubview(self.titleLabel, anchors: [
            .top(to: self.alertImageView.bottomAnchor, constant: 30),
            .centerX(to: self.centerXAnchor)
        ])
    }

}

class HomeAlertViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Good morning, John!"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 50/255, green: 75/255, blue: 78/255, alpha: 1)
        return label
    }()

    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "you have 3 new notifications!"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(red: 50/255, green: 75/255, blue: 78/255, alpha: 1)
        return label
    }()

    let callAlertView: HomeAlertView = {
        let view = HomeAlertView()
        view.alertImageView.image = UIImage(named: "home_alert_call")
        view.titleLabel.text = "1 missed call"
        return view
    }()

    let messageAlertView: HomeAlertView = {
        let view = HomeAlertView()
        view.alertImageView.image = UIImage(named: "home_alert_message")
        view.titleLabel.text = "0 new messages"
        return view
    }()

    let profileAlertView: HomeAlertView = {
        let view = HomeAlertView()
        view.alertImageView.image = UIImage(named: "home_alert_profile")
        view.titleLabel.text = "2 new alerts"
        return view
    }()

    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(UIColor(red: 50/255, green: 75/255, blue: 78/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    @objc func close(_ sender: Any) {
        self.dismiss(animated: true)
    }

    fileprivate func configureView() {
        self.view.addSubview(self.titleLabel, anchors: [
            .top(to: self.view.topAnchor, constant: 36),
            .centerX(to: self.view.centerXAnchor)
        ])

        self.view.addSubview(self.subTitleLabel, anchors: [
            .top(to: self.titleLabel.bottomAnchor, constant: 4),
            .centerX(to: self.view.centerXAnchor)
        ])

        let stackView = UIStackView(arrangedSubviews: [self.callAlertView, self.messageAlertView, self.profileAlertView])
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        self.view.addSubview(stackView, anchors: [
            .top(to: self.subTitleLabel.bottomAnchor, constant: 32),
            .leading(to: self.view.leadingAnchor, constant: 10),
            .trailing(to: self.view.trailingAnchor, constant: 10),
            .height(constant: 140)
        ])

        self.view.addSubview(self.dismissButton, anchors: [
            .top(to: stackView.bottomAnchor, constant: 16),
            .leading(to: self.view.leadingAnchor, constant: 20),
            .trailing(to: self.view.trailingAnchor, constant: 20),
            .height(constant: 46)
        ])
    }

}

extension HomeAlertViewController: FloatingPanelLayout {

    var position: FloatingPanelPosition { .bottom }

    var initialState: FloatingPanelState { .tip }

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 335, edge: .bottom, referenceGuide: .superview)
        ]
    }

    func backdropAlpha(for state: FloatingPanelState) -> CGFloat { return 0.7 }

}
