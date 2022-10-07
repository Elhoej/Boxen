//
//  MenuViewController.swift
//  BoxenAdmin
//
//  Created by Simon Elhøj Steinmejer on 29/06/2022.
//

import UIKit

protocol SideMenuDelegate: AnyObject {
    func menuButtonTapped()
    func itemSelected(item: ContentViewControllerPresentation)
}

enum ContentViewControllerPresentation {
    case embed(ContentViewController)
    case push(UIViewController)
    case modal(UIViewController)
}

class ContentViewController: UIViewController {

    weak var delegate: SideMenuDelegate?
    var barButtonImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    convenience init(barButtonImage: UIImage?) {
        self.init()
        self.barButtonImage = barButtonImage
    }

     func configureView() {
        let barButtonItem = UIBarButtonItem(image: barButtonImage, style: .plain, target: self, action: #selector(menuTapped))
        barButtonItem.tintColor = UIColor(red: 100/255, green: 115/255, blue: 140/255, alpha: 1)
        navigationItem.setLeftBarButton(barButtonItem, animated: false)
    }

    @objc func menuTapped() {
        delegate?.menuButtonTapped()
    }

}

final class ContainerViewController: UIViewController {

    var sideMenuViewController: SideMenuViewController!
    var navigator: UINavigationController!
    var rootViewController: ContentViewController! {
        didSet {
            self.rootViewController.delegate = self
            navigator.setViewControllers([self.rootViewController], animated: false)
        }
    }

    convenience init(sideMenuViewController: SideMenuViewController, rootViewController: ContentViewController) {
        self.init()
        self.sideMenuViewController = sideMenuViewController
        self.rootViewController = rootViewController
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.setNavigationBarHidden(true, animated: false)
        self.navigator = navController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        addChildViewControllers()
        configureDelegates()
        configureGestures()
    }

    private func configureDelegates() {
        sideMenuViewController.delegate = self
        rootViewController.delegate = self
    }

    private func configureGestures() {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        swipeLeftGesture.direction = .left
        swipeLeftGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(swipeLeftGesture)

        let rightSwipeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(swipedRight))
        rightSwipeGesture.cancelsTouchesInView = false
        rightSwipeGesture.edges = .left
        view.addGestureRecognizer(rightSwipeGesture)
    }

    @objc private func swipedLeft() {
        sideMenuViewController.hide()
    }

    @objc private func swipedRight() {
        sideMenuViewController.show()
    }

    func updateRootViewController(_ viewController: ContentViewController) {
        rootViewController = viewController
    }

    private func addChildViewControllers() {
        addChild(navigator)
        view.addSubview(navigator.view)
        navigator.didMove(toParent: self)

        addChild(sideMenuViewController)
        view.addSubview(sideMenuViewController.view)
        sideMenuViewController.didMove(toParent: self)
    }
}

extension ContainerViewController: SideMenuDelegate {
    func menuButtonTapped() {
        sideMenuViewController.show()
    }

    func itemSelected(item: ContentViewControllerPresentation) {
        switch item {
        case let .embed(viewController):
            updateRootViewController(viewController)
            sideMenuViewController.hide()
        case let .push(viewController):
            sideMenuViewController.hide()
            navigator.pushViewController(viewController, animated: true)
        case let .modal(viewController):
            sideMenuViewController.hide()
            navigator.present(viewController, animated: true, completion: nil)
        }
    }
}

struct SideMenuItem {
    let icon: UIImage?
    let name: String
    let viewController: ContentViewControllerPresentation
}


final class SideMenuItemCell: UITableViewCell {

    private var itemIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: SideMenuItemCell.identifier)
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    private func configureView() {
        contentView.backgroundColor = .white
        contentView.addSubview(itemIcon)
        contentView.addSubview(itemLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureConstraints()
    }

    private func configureConstraints() {
        itemIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        itemIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        itemIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        itemIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22).isActive = true

        itemLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        itemLabel.leadingAnchor.constraint(equalTo: itemIcon.trailingAnchor, constant: 20).isActive = true
        itemLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22).isActive = true
    }

    func configureCell(icon: UIImage?, text: String) {
        itemIcon.image = icon
        itemLabel.text = text
    }
}

final class SideMenuViewController: UIViewController {
    private var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private var headerImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "profile_image"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "John Doe"
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        label.textColor = UIColor(red: 100/255, green: 115/255, blue: 140/255, alpha: 1)
        label.textAlignment = .center
        return label
    }()

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private var sideMenuView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var sideMenuItems: [SideMenuItem] = []
    private var leadingConstraint: NSLayoutConstraint!
    private var shadowColor: UIColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 0.5)
    weak var delegate: SideMenuDelegate?

    convenience init(sideMenuItems: [SideMenuItem]) {
        self.init()
        self.sideMenuItems = sideMenuItems
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func show() {
        self.view.frame.origin.x = 0
        self.view.backgroundColor = self.shadowColor
        UIView.animate(withDuration: 0.5) {
            self.leadingConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }

    func hide() {
        self.view.backgroundColor = .clear
        UIView.animate(withDuration: 0.5) {
            self.leadingConstraint.constant = -UIScreen.main.bounds.width
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.view.frame.origin.x = -UIScreen.main.bounds.width
        }
    }

    private func configureView() {
        view.backgroundColor = .clear
        view.frame.origin.x = -UIScreen.main.bounds.width

        addSubviews()
        configureTableView()
        configureTapGesture()
    }

    private func addSubviews() {
        view.addSubview(sideMenuView)
        sideMenuView.addSubview(headerView)
        sideMenuView.addSubview(tableView)
        configureConstraints()
    }

    private func configureConstraints() {
        sideMenuView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingConstraint = sideMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -view.frame.size.width)
        leadingConstraint.isActive = true
        sideMenuView.widthAnchor.constraint(equalToConstant: view.frame.size.width * 0.5).isActive = true
        sideMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        headerView.topAnchor.constraint(equalTo: sideMenuView.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: sideMenuView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: sideMenuView.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 250).isActive = true

        self.headerView.addSubview(self.headerImageView, anchors: [
            .top(to: self.headerView.topAnchor, constant: 80),
            .centerX(to: self.headerView.centerXAnchor),
            .height(constant: 100),
            .width(constant: 100)
        ])

        self.headerView.addSubview(self.headerLabel, anchors: [
            .top(to: self.headerImageView.bottomAnchor, constant: 12),
            .leading(to: self.headerView.leadingAnchor, constant: 10),
            .trailing(to: self.headerView.trailingAnchor, constant: 10)
        ])

        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: sideMenuView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: sideMenuView.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: sideMenuView.bottomAnchor).isActive = true
    }

    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.register(SideMenuItemCell.self, forCellReuseIdentifier: SideMenuItemCell.identifier)
    }

    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func tapped() {
        hide()
    }
}

extension SideMenuViewController: UIGestureRecognizerDelegate {
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let view = touch.view else { return false }
        if view === headerView || view.isDescendant(of: tableView) {
            return false
        }
        return true
    }
}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sideMenuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: SideMenuItemCell.self, for: indexPath)
        let item = sideMenuItems[indexPath.row]
        cell.configureCell(icon: item.icon, text: item.name)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let item = sideMenuItems[indexPath.row]
        delegate?.itemSelected(item: item.viewController)
    }
}
