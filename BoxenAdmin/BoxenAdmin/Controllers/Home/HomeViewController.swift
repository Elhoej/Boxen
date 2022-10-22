//
//  ViewController.swift
//  BoxenAdmin
//
//  Created by Simon Elhøj Steinmejer on 28/10/2021.
//

import UIKit
import Parse
import FloatingPanel

class HomeViewController: ContentViewController {

    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Here is your pill\nschedule for the day:"
        label.numberOfLines = 2
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()

    lazy var menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "menu_icon_new"), for: .normal)
        button.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        return button
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

    lazy var addPillButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "add_pill_icon"), for: .normal)
        button.addTarget(self, action: #selector(addPill), for: .touchUpInside)
        return button
    }()

    lazy var breakfastButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("2", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.layer.cornerRadius = 27
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    lazy var lunchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("4", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.layer.cornerRadius = 27
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    lazy var dinnerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("1", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.layer.cornerRadius = 27
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    let breakfastLabel: UILabel = {
        let label = UILabel()
        label.text = "after\nbreakfast"
        label.numberOfLines = 2
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    let lunchLabel: UILabel = {
        let label = UILabel()
        label.text = "during\nlunch"
        label.numberOfLines = 2
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    let dinnerLabel: UILabel = {
        let label = UILabel()
        label.text = "after\ndinner"
        label.numberOfLines = 2
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    lazy var progressButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "progress_icon"), for: .normal)
        button.layer.cornerRadius = 27
        button.layer.masksToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = true
        return button
    }()

    let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "view\nprogress"
        label.numberOfLines = 2
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(cell: MenuItemCell.self)
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = true
        return cv
    }()


    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.register(cell: HomeDayCell.self)
        tv.separatorInset = .zero
        tv.delaysContentTouches = false
        tv.separatorStyle = .none
        return tv
    }()

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        let colorTop = UIColor(red: 0.37, green: 0.48, blue: 0.53, alpha: 1.00).cgColor
//        let colorBottom = UIColor(red: 0.72, green: 0.70, blue: 0.64, alpha: 1.00).cgColor
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [colorTop, colorBottom]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
//        gradientLayer.frame = self.topView.bounds
//
//        self.topView.layer.insertSublayer(gradientLayer, at:0)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureAutoLayout()
    }

    override func configureView() {
        self.view.backgroundColor = .white
        self.menuButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
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
        self.view.addSubview(self.topView, anchors: [
            .top(to: self.view.topAnchor),
            .leading(to: self.view.leadingAnchor),
            .trailing(to: self.view.trailingAnchor),
            .height(constant: 328)
        ])

        self.view.addSubview(self.menuButton, anchors: [
            .top(to: self.view.topAnchor, constant: 50),
            .leading(to: self.view.leadingAnchor, constant: 16),
            .height(constant: 38),
            .width(constant: 38)
        ])

        self.topView.addSubview(self.alertButton, anchors: [
            .top(to: self.view.topAnchor, constant: 50),
            .trailing(to: self.topView.trailingAnchor, constant: 16),
            .height(constant: 38),
            .width(constant: 38)
        ])

        self.topView.addSubview(self.profileButton, anchors: [
            .centerY(to: self.alertButton.centerYAnchor),
            .trailing(to: self.alertButton.leadingAnchor, constant: 8),
            .height(constant: 38),
            .width(constant: 38)
        ])


        self.topView.addSubview(self.titleLabel, anchors: [
            .top(to: self.profileButton.bottomAnchor, constant: 16),
            .leading(to: self.view.leadingAnchor, constant: 22)
        ])

        self.view.addSubview(self.breakfastButton, anchors: [
            .top(to: self.titleLabel.bottomAnchor, constant: 12),
            .leading(to: self.view.leadingAnchor, constant: 32),
            .height(constant: 54),
            .width(constant: 54)
        ])

        self.view.addSubview(self.breakfastLabel, anchors: [
            .top(to: self.breakfastButton.bottomAnchor, constant: 10),
            .centerX(to: self.breakfastButton.centerXAnchor)
        ])

        self.view.addSubview(self.lunchButton, anchors: [
            .top(to: self.titleLabel.bottomAnchor, constant: 12),
            .leading(to: self.breakfastButton.trailingAnchor, constant: 32),
            .height(constant: 54),
            .width(constant: 54)
        ])

        self.view.addSubview(self.lunchLabel, anchors: [
            .top(to: self.lunchButton.bottomAnchor, constant: 10),
            .centerX(to: self.lunchButton.centerXAnchor)
        ])

        self.view.addSubview(self.dinnerButton, anchors: [
            .top(to: self.titleLabel.bottomAnchor, constant: 12),
            .leading(to: self.lunchButton.trailingAnchor, constant: 32),
            .height(constant: 54),
            .width(constant: 54)
        ])

        self.view.addSubview(self.dinnerLabel, anchors: [
            .top(to: self.dinnerButton.bottomAnchor, constant: 10),
            .centerX(to: self.dinnerButton.centerXAnchor)
        ])

        self.view.addSubview(self.progressButton, anchors: [
            .top(to: self.titleLabel.bottomAnchor, constant: 12),
            .leading(to: self.dinnerButton.trailingAnchor, constant: 32),
            .height(constant: 54),
            .width(constant: 54)
        ])

        self.view.addSubview(self.progressLabel, anchors: [
            .top(to: self.progressButton.bottomAnchor, constant: 10),
            .centerX(to: self.progressButton.centerXAnchor)
        ])

        self.topView.addSubview(self.collectionView, anchors: [
            .bottom(to: self.topView.bottomAnchor),
            .leading(to: self.topView.leadingAnchor),
            .trailing(to: self.topView.trailingAnchor),
            .top(to: self.breakfastLabel.bottomAnchor, constant: 12)
        ])

        self.view.addSubview(self.tableView, anchors: [
            .top(to: self.topView.bottomAnchor),
            .leading(to: self.view.leadingAnchor),
            .trailing(to: self.view.trailingAnchor),
            .bottom(to: self.view.bottomAnchor)
        ])

        self.view.addSubview(self.addPillButton, anchors: [
            .bottom(to: self.view.bottomAnchor, constant: -80),
            .trailing(to: self.view.trailingAnchor, constant: 16),
            .height(constant: 60),
            .width(constant: 60)
        ])

    }
}

extension HomeViewController: HomeDayCellDelegate {
    func didSelect() {
        let controller = PillDetailViewController()
        self.navigationController?.present(controller, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: HomeDayCell.self, for: indexPath)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 236
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: MenuItemCell.self, for: indexPath)
        switch indexPath.item {
            case 0:
                cell.menuNameLabel.text = "Medicines to take"
                cell.menuNameLabel.textColor = .white
            case 1:
                cell.menuNameLabel.text = "Missed medicine"
                cell.menuNameLabel.textColor = UIColor(red: 134/255, green: 36/255, blue: 0/255, alpha: 0.5)
            case 2:
                cell.menuNameLabel.text = "Upcoming medicine"
                cell.menuNameLabel.textColor = UIColor(red: 100/255, green: 115/255, blue: 140/255, alpha: 0.35)
            default: fatalError()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: collectionView.frame.height)
    }
}
