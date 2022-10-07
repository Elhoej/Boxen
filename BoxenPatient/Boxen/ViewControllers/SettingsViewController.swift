//
//  SettingsViewController.swift
//  Boxen
//
//  Created by Simon Elhøj Steinmejer on 07/10/2020.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var messageSwitch: UISwitch!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var messageOn: Bool {
        get { return UserDefaults.standard.bool(forKey: "messageOn") }
        set { UserDefaults.standard.setValue(newValue, forKey: "messageOn") }
    }

    var message: String {
        get { return UserDefaults.standard.string(forKey: "message") ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: "message") }
    }
    
    var phoneNumber: String {
        get { return UserDefaults.standard.string(forKey: "phone") ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: "phone") }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
        self.title = "Indstillinger"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Indstillinger"
        
        self.messageSwitch.isOn = self.messageOn
        self.messageTextView.text = self.message
        self.phoneTextField.text = self.phoneNumber
    }
    
    @IBAction func messageSwitchChanged(_ sender: UISwitch) {
        
    }
    
    @IBAction func save(_ sender: Any) {
        
        self.messageOn = self.messageSwitch.isOn
        self.message = self.messageTextView.text
        self.phoneNumber = self.phoneTextField.text ?? ""
        
        self.alert(title: "Du har gemt dine indstillinger")
    }
    
    
}
