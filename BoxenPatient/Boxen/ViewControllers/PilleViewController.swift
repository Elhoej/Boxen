//
//  ViewController.swift
//  Boxen
//
//  Created by Simon Elhøj Steinmejer on 07/10/2020.
//

import UIKit
import Parse

class PilleViewController: UIViewController {

    let menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(menu), for: .touchUpInside)
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        return button
    }()

    let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(profile), for: .touchUpInside)
        button.setImage(UIImage(named: "profile_icon"), for: .normal)
        button.layer.cornerRadius = 62
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        return button
    }()

    let createPillButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(createNewPill), for: .touchUpInside)
        button.setImage(UIImage(named: "add_icon"), for: .normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        return button
    }()

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.register(cell: PillCollectionCell.self)
        return tv
    }()

    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        return df
    }()
    
    var messageOn: Bool {
        get { return UserDefaults.standard.bool(forKey: "messageOn") }
    }
    
    var message: String {
        get { return UserDefaults.standard.string(forKey: "message") ?? "" }
    }
    
    var phoneNumber: String {
        get { return UserDefaults.standard.string(forKey: "phone") ?? "" }
    }
    
    var lastDateString: String {
        get { return UserDefaults.standard.string(forKey: "lastDate") ?? "01/01/2000" }
        set { return UserDefaults.standard.setValue(newValue, forKey: "lastDate") }
    }
    
    var todaysPills = [Pill]()
    var missedPills = [Pill]()
    var completedPills = [Pill]()
    
    let df: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureAutoLayout()
        self.fetchPills()
    }

    fileprivate func fetchPills() {
        guard let user = User.current() else { return }
        let query = Pill.query()
        query?.whereKey("user", equalTo: user)
        query?.findObjectsInBackground(block: { objects, error in
            if var pills = objects as? [Pill] {

                let consumptionQuery = PillConsumption.query()
                consumptionQuery?.whereKey("user", equalTo: user)
                consumptionQuery?.whereKey("pill", containedIn: pills)
                consumptionQuery?.findObjectsInBackground(block: { cObjects, error in
                    if let pillConsumptions = cObjects as? [PillConsumption] {
                        for pillConsumption in pillConsumptions {
                            if Calendar.current.isDate(pillConsumption.createdAt!, inSameDayAs: Date()) {
                                pills.remove(element: pillConsumption.pill)
                                self.completedPills.append(pillConsumption.pill)
                            }
                        }
                    }
                })

                for pill in pills {
                    let nowString = self.dateFormatter.string(from: Date())
                    let now = self.dateFormatter.date(from: nowString)!
                    let time = self.dateFormatter.date(from: pill.time)!
                    if now > time {
                        self.missedPills.append(pill)
                    } else {
                        self.todaysPills.append(pill)
                    }
                }
                self.tableView.reloadData()
            }
        })
    }

    fileprivate func configureView() {
        self.view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name("refresh"), object: nil)
    }

    fileprivate func configureAutoLayout() {
        self.view.addSubview(self.profileButton, anchors: [
            .centerX(to: self.view.centerXAnchor),
            .top(to: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            .height(constant: 124),
            .width(constant: 124)
        ])

        self.view.addSubview(self.menuButton, anchors: [
            .leading(to: self.view.leadingAnchor, constant: 40),
            .bottom(to: self.profileButton.bottomAnchor, constant: -20),
            .height(constant: 50),
            .width(constant: 50)
        ])

        self.view.addSubview(self.createPillButton, anchors: [
            .trailing(to: self.view.trailingAnchor, constant: 40),
            .bottom(to: self.profileButton.bottomAnchor, constant: -20),
            .height(constant: 50),
            .width(constant: 50)
        ])

        self.view.addSubview(self.tableView, anchors: [
            .top(to: self.profileButton.bottomAnchor, constant: 24),
            .leading(to: self.view.leadingAnchor),
            .trailing(to: self.view.trailingAnchor),
            .bottom(to: self.view.bottomAnchor)
        ])
    }

    @objc fileprivate func menu() {

    }

    @objc fileprivate func profile() {
        let alert = UIAlertController(title: "What would you like to inform your caretaker about?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "I'm at the hospital", style: .default, handler: { _ in
            let secondAlert = UIAlertController(title: "Thank you, we have send a message to your caretaker", message: nil, preferredStyle: .alert)
            secondAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(secondAlert, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "I'm on vacation", style: .default, handler: { _ in

        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @objc fileprivate func logout() {
        User.logOutInBackground { error in
            self.alert(title: "Du er nu logget ud", message: "", completion: {
                UIApplication.shared.keyWindow?.rootViewController = SignInViewController()
            }, cancellable: false)
        }
    }

    @objc fileprivate func refresh() {
        self.fetchPills()
    }
    
    @objc fileprivate func createNewPill() {
        let controller = CreatePillViewController()
        let navController = UINavigationController(rootViewController: controller)
        self.present(navController, animated: true, completion: nil)
    }
}

extension PilleViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: PillCollectionCell.self, for: indexPath)
        switch indexPath.row {
            case 0:
                cell.delegate = self
                cell.type = .upcoming
                cell.titleLabel.text = "Pills to take:"
                cell.timeLabel.text = self.dateFormatter.string(from: Date())
                cell.pills = self.todaysPills
            case 1:
                cell.delegate = self
                cell.type = .missed
                cell.titleLabel.text = "Missed medications"
                cell.timeLabel.text = ""
                cell.pills = self.missedPills
            case 2:
                cell.type = .missed
                cell.titleLabel.text = "Completed pills"
                cell.timeLabel.text = ""
                cell.pills = self.completedPills
            default: break
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
}

extension PilleViewController: PillCollectionCellDelegate {
    func upcomingPillPressed(pill: Pill) {

        self.todaysPills.remove(element: pill)
        self.completedPills.append(pill)

        let pillConsumption = PillConsumption()
        pillConsumption.user = User.current()!
        pillConsumption.pill = pill
        pillConsumption.saveInBackground()

        if self.todaysPills.isEmpty && self.messageOn {
            let alert = UIAlertController(title: "Du har taget alle dine piller for i dag, vil du sende besked ud nu?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ja", style: .default, handler: { (_) in

                let sms: String = "sms:+45\(self.phoneNumber)&body=\(self.message)"
                let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)

            }))
            alert.addAction(UIAlertAction(title: "Annuller", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func missedPillPressed(pill: Pill) {

    }
}

