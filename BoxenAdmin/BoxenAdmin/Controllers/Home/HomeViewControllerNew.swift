//
//  HomeViewControllerNew.swift
//  Boxenv2
//
//  Created by Simon Elhøj Steinmejer on 16/10/2022.
//

import UIKit
import Parse
import FloatingPanel

class HomeViewControllerNew: ContentViewController {

    lazy var addPillButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "add_pill_icon"), for: .normal)
        button.addTarget(self, action: #selector(addPill), for: .touchUpInside)
        return button
    }()

    let topIlluImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home_illu_one")
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    let buttomIlluImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home_illu_two")
        return iv
    }()

    lazy var topBlurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .regular)
        let vev = UIVisualEffectView(effect: blur)
        vev.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vev.alpha = 0.7
        return vev
    }()

    lazy var menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "menu_icon_new"), for: .normal)
        button.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        return button
    }()

    let buttonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = rgba(52, 77, 80, 1)
        view.layer.cornerRadius = 23
        view.layer.masksToBounds = true
        return view
    }()

    lazy var alertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "alert_icon_new"), for: .normal)
        button.addTarget(self, action: #selector(openAlert), for: .touchUpInside)
        return button
    }()

    lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "profile_icon_new"), for: .normal)
        button.addTarget(self, action: #selector(openHomeProfile), for: .touchUpInside)
        return button
    }()

    let profileBackgroundView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blur)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.backgroundColor = rgba(52, 77, 80, 0.75)
        return view
    }()

    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "test_profile")
        return iv
    }()

    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Robert Fox"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    let progressButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "progress_button"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()

    let overviewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = rgba(52, 77, 80, 1).cgColor
        return view
    }()

    let overviewLabel: UILabel = {
        let label = UILabel()
        var attributedString = NSMutableAttributedString(string: "After", attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .regular),
            .foregroundColor: rgba(50, 75, 78, 1)
        ])
        attributedString.append(NSAttributedString(string: " breakfast:", attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .foregroundColor: rgba(50, 75, 78, 1)
        ]))
        label.attributedText = attributedString
        return label
    }()

    let testView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "testlol")
        return iv
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureAutoLayout()
        self.configureView()
    }

    override func configureView() {
        self.view.backgroundColor = .white
    }

    @objc fileprivate func showMenu() {
        self.delegate?.menuButtonTapped()
    }

    @objc fileprivate func openAlert() {
        let controller = HomeAlertViewController()
        let panel = FloatingPanelController(controller: controller, action: #selector(HomeAlertViewController.close(_:)))
        self.navigationController?.present(panel, animated: true, completion: nil)
    }

    @objc fileprivate func openHomeProfile() {
        let controller = HomeProfileViewController()
        let panel = FloatingPanelController(controller: controller, action: #selector(HomeProfileViewController.close(_:)))
        self.navigationController?.present(panel, animated: true, completion: nil)
    }

    @objc fileprivate func addPill() {
        let controller = CreatePillViewController()
        self.delegate?.itemSelected(item: .modal(controller))
    }


    fileprivate func configureAutoLayout() {
        self.view.addSubview(self.topIlluImageView, anchors: [
            .top(to: self.view.topAnchor),
            .leading(to: self.view.leadingAnchor),
            .height(constant: 360),
            .width(constant: 160)
        ])

        self.view.addSubview(self.buttomIlluImageView, anchors: [
            .top(to: self.view.topAnchor, constant: 272),
            .trailing(to: self.view.trailingAnchor, constant: 8),
            .height(constant: 100),
            .width(constant: 100)
        ])

        self.view.addSubview(self.topBlurView, anchors: [
            .top(to: self.view.topAnchor),
            .leading(to: self.view.leadingAnchor),
            .trailing(to: self.view.trailingAnchor),
            .bottom(to: self.view.safeAreaLayoutGuide.topAnchor, constant: 48)
        ])

        self.view.addSubview(self.menuButton, anchors: [
            .leading(to: self.view.leadingAnchor, constant: 16),
            .bottom(to: self.topBlurView.bottomAnchor, constant: -10),
            .width(constant: 48),
            .height(constant: 48)
        ])

        self.view.addSubview(self.buttonBackgroundView, anchors: [
            .trailing(to: self.view.trailingAnchor, constant: 16),
            .bottom(to: self.topBlurView.bottomAnchor, constant: -10),
            .height(constant: 46),
            .width(constant: 94)
        ])

        self.buttonBackgroundView.addSubview(self.alertButton, anchors: [
            .top(to: self.buttonBackgroundView.topAnchor, constant: 2),
            .leading(to: self.buttonBackgroundView.leadingAnchor, constant: 2),
            .bottom(to: self.buttonBackgroundView.bottomAnchor, constant: -2)
        ])
        self.alertButton.widthAnchor.constraint(equalTo: self.alertButton.heightAnchor).isActive = true

        self.buttonBackgroundView.addSubview(self.profileButton, anchors: [
            .top(to: self.buttonBackgroundView.topAnchor, constant: 2),
            .trailing(to: self.buttonBackgroundView.trailingAnchor, constant: 2),
            .bottom(to: self.buttonBackgroundView.bottomAnchor, constant: -2)
        ])
        self.profileButton.widthAnchor.constraint(equalTo: self.profileButton.heightAnchor).isActive = true

        self.view.addSubview(self.profileBackgroundView, anchors: [
            .top(to: self.topBlurView.bottomAnchor, constant: 12),
            .leading(to: self.view.leadingAnchor, constant: 14),
            .height(constant: 206),
            .width(constant: 165)
        ])

        self.view.addSubview(self.profileImageView, anchors: [
            .top(to: self.profileBackgroundView.topAnchor, constant: 16),
            .centerX(to: self.profileBackgroundView.centerXAnchor),
            .width(constant: 100),
            .height(constant: 100)
        ])

        self.view.addSubview(self.profileNameLabel, anchors: [
            .top(to: self.profileImageView.bottomAnchor, constant: 8),
            .leading(to: self.profileBackgroundView.leadingAnchor, constant: 4),
            .trailing(to: self.profileBackgroundView.trailingAnchor, constant: 4)
        ])

        self.view.addSubview(self.progressButton, anchors: [
            .top(to: self.profileNameLabel.bottomAnchor, constant: 10),
            .leading(to: self.profileBackgroundView.leadingAnchor, constant: 18),
            .trailing(to: self.profileBackgroundView.trailingAnchor, constant: 18),
            .height(constant: 36)
        ])

        self.view.addSubview(self.overviewBackground, anchors: [
            .top(to: self.topBlurView.bottomAnchor, constant: 12),
            .leading(to: self.profileBackgroundView.trailingAnchor, constant: 10),
            .trailing(to: self.view.trailingAnchor, constant: 14),
            .height(constant: 115)
        ])

        self.overviewBackground.addSubview(self.overviewLabel, anchors: [
            .top(to: self.overviewBackground.topAnchor, constant: 16),
            .leading(to: self.overviewBackground.leadingAnchor, constant: 16)
        ])

        self.view.addSubview(self.testView, anchors: [
            .top(to: self.overviewBackground.bottomAnchor, constant: 8),
            .leading(to: self.profileBackgroundView.trailingAnchor, constant: 10),
            .trailing(to: self.view.trailingAnchor, constant: 14),
            .height(constant: 84)
        ])


        self.view.addSubview(self.addPillButton, anchors: [
            .bottom(to: self.view.bottomAnchor, constant: -80),
            .trailing(to: self.view.trailingAnchor, constant: 16),
            .height(constant: 60),
            .width(constant: 60)
        ])


//        self.topView.addSubview(self.backgroundImageView, anchors: [.fill()])
//
//        self.view.addSubview(self.menuButton, anchors: [
//            .top(to: self.view.topAnchor, constant: 50),
//            .leading(to: self.view.leadingAnchor, constant: 16),
//            .height(constant: 38),
//            .width(constant: 38)
//        ])
//
//        self.topView.addSubview(self.alertButton, anchors: [
//            .top(to: self.view.topAnchor, constant: 50),
//            .trailing(to: self.topView.trailingAnchor, constant: 16),
//            .height(constant: 38),
//            .width(constant: 38)
//        ])
//
//        self.topView.addSubview(self.profileButton, anchors: [
//            .centerY(to: self.alertButton.centerYAnchor),
//            .trailing(to: self.alertButton.leadingAnchor, constant: 8),
//            .height(constant: 38),
//            .width(constant: 38)
//        ])
//
//
//        self.topView.addSubview(self.titleLabel, anchors: [
//            .top(to: self.profileButton.bottomAnchor, constant: 16),
//            .leading(to: self.view.leadingAnchor, constant: 22)
//        ])
//
//        self.view.addSubview(self.breakfastButton, anchors: [
//            .top(to: self.titleLabel.bottomAnchor, constant: 12),
//            .leading(to: self.view.leadingAnchor, constant: 32),
//            .height(constant: 54),
//            .width(constant: 54)
//        ])
//
//        self.view.addSubview(self.breakfastLabel, anchors: [
//            .top(to: self.breakfastButton.bottomAnchor, constant: 10),
//            .centerX(to: self.breakfastButton.centerXAnchor)
//        ])
//
//        self.view.addSubview(self.lunchButton, anchors: [
//            .top(to: self.titleLabel.bottomAnchor, constant: 12),
//            .leading(to: self.breakfastButton.trailingAnchor, constant: 32),
//            .height(constant: 54),
//            .width(constant: 54)
//        ])
//
//        self.view.addSubview(self.lunchLabel, anchors: [
//            .top(to: self.lunchButton.bottomAnchor, constant: 10),
//            .centerX(to: self.lunchButton.centerXAnchor)
//        ])
//
//        self.view.addSubview(self.dinnerButton, anchors: [
//            .top(to: self.titleLabel.bottomAnchor, constant: 12),
//            .leading(to: self.lunchButton.trailingAnchor, constant: 32),
//            .height(constant: 54),
//            .width(constant: 54)
//        ])
//
//        self.view.addSubview(self.dinnerLabel, anchors: [
//            .top(to: self.dinnerButton.bottomAnchor, constant: 10),
//            .centerX(to: self.dinnerButton.centerXAnchor)
//        ])
//
//        self.view.addSubview(self.progressButton, anchors: [
//            .top(to: self.titleLabel.bottomAnchor, constant: 12),
//            .leading(to: self.dinnerButton.trailingAnchor, constant: 32),
//            .height(constant: 54),
//            .width(constant: 54)
//        ])
//
//        self.view.addSubview(self.progressLabel, anchors: [
//            .top(to: self.progressButton.bottomAnchor, constant: 10),
//            .centerX(to: self.progressButton.centerXAnchor)
//        ])
//
//        self.topView.addSubview(self.collectionView, anchors: [
//            .bottom(to: self.topView.bottomAnchor),
//            .leading(to: self.topView.leadingAnchor),
//            .trailing(to: self.topView.trailingAnchor),
//            .top(to: self.breakfastLabel.bottomAnchor, constant: 12)
//        ])
//
//        self.view.addSubview(self.tableView, anchors: [
//            .top(to: self.topView.bottomAnchor),
//            .leading(to: self.view.leadingAnchor),
//            .trailing(to: self.view.trailingAnchor),
//            .bottom(to: self.view.bottomAnchor)
//        ])
//
//        self.view.addSubview(self.addPillButton, anchors: [
//            .bottom(to: self.view.bottomAnchor, constant: -80),
//            .trailing(to: self.view.trailingAnchor, constant: 16),
//            .height(constant: 60),
//            .width(constant: 60)
//        ])

    }

}
