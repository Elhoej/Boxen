//
//  CustomTextField.swift
//  LoginDemo
//
//  Created by Simon Elhøj Steinmejer on 10/05/2019.
//  Copyright © 2019 Simon Elhøj Steinmejer. All rights reserved.
//

import UIKit

protocol FloatingTextFieldDelegate: class {
    func textFieldIsActive()
    func textFieldIsInactive()
}

class FloatingTextField: UITextField, UITextFieldDelegate {
    
    weak var floatingDelegate: FloatingTextFieldDelegate?
    
    @IBInspectable
    var floatingFont: UIFont? {
        didSet {
            self.titleLabel.font = self.floatingFont
        }
    }
    
    @IBInspectable
    var underlineColor: UIColor? {
        didSet {
            self.underLine.backgroundColor = self.underlineColor
        }
    }
    
    @IBInspectable
    var eraseButtonColor: UIColor? {
        didSet {
            self.eraseButton.tintColor = self.eraseButtonColor
        }
    }
    
    @IBInspectable
    var eraseButtonEnabled = true
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.sizeToFit()
        return label
    }()
    
    let underLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 1
        return view
    }()
    
    let eraseButton: UIButton = {
        let button = UIButton(type: .system)
        button.alpha = 0
        button.setImage(UIImage(named: "ico_close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(erase), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(placeholderText: String) {
        self.init()
        titleLabel.text = placeholderText
        if placeholderText.lowercased().contains("pass") {
            self.isSecureTextEntry = true
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 4, y: 0, width: bounds.width - (eraseButton.bounds.width + 8), height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 4, y: 0, width: bounds.width - (eraseButton.bounds.width + 8), height: bounds.height)
    }
    
    var underLineHeightAnchor: NSLayoutConstraint?
    var titleLabelBottomAnchorToUnderLine: NSLayoutConstraint?
    var titleLabelButtomAnchorToTextField: NSLayoutConstraint?
    
    @objc fileprivate func erase() {
        self.text = nil
    }
    
    fileprivate func setup() {
        self.delegate = self
        self.tintColor = .clear
        self.backgroundColor = .clear
        self.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        
        addSubview(underLine)
        underLine.translatesAutoresizingMaskIntoConstraints = false
        underLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        underLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        underLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        underLineHeightAnchor = underLine.heightAnchor.constraint(equalToConstant: 1)
        underLineHeightAnchor?.isActive = true
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        titleLabelBottomAnchorToUnderLine = titleLabel.bottomAnchor.constraint(equalTo: underLine.topAnchor, constant: -12)
        titleLabelBottomAnchorToUnderLine?.isActive = true
        titleLabelButtomAnchorToTextField = titleLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -2)
        
        if self.eraseButtonEnabled {
            addSubview(eraseButton)
            eraseButton.translatesAutoresizingMaskIntoConstraints = false
            eraseButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
            eraseButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6).isActive = true
            eraseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
            eraseButton.widthAnchor.constraint(equalTo: eraseButton.heightAnchor, constant: 0).isActive = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.floatingDelegate?.textFieldIsActive()
        
        underLineHeightAnchor?.constant = self.bounds.height
        titleLabelBottomAnchorToUnderLine?.isActive = false
        titleLabelButtomAnchorToTextField?.isActive = true
        
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            
            self.underLine.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
            self.titleLabel.textColor = .black
            self.eraseButton.alpha = 1
            self.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.floatingDelegate?.textFieldIsInactive()
        
        guard let text = self.text else { return }
        
        underLineHeightAnchor?.constant = 1
        titleLabelButtomAnchorToTextField?.isActive = text.isEmpty ? false : true
        titleLabelBottomAnchorToUnderLine?.isActive = text.isEmpty ? true : false
        
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            
            self.underLine.backgroundColor = .lightGray
            self.titleLabel.textColor = text.isEmpty ? .gray : .black
            self.eraseButton.alpha = 0
            self.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
