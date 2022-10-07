//
//  PillTextField.swift
//  Boxen
//
//  Created by Simon Elhøj Steinmejer on 16/10/2021.
//

import UIKit
import MustacheUIKit

class PillTextField: UIView {

    var title: String = "" {
        didSet {
            self.titleLabel.text = self.title
        }
    }

    var placeholder: String = "" {
        didSet {
            self.textField.placeholder = self.placeholder
        }
    }

    var showImage: Bool = false {
        didSet {
            self.arrowImageView.isHidden = !self.showImage
        }
    }

    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .clear
        return view
    }()

    let titleLabel: EdgeInsetLabel = {
        let label = EdgeInsetLabel()
        label.textInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        label.backgroundColor = .white
        return label
    }()

    let textField: UITextField = {
        let tf = UITextField()
        return tf
    }()

    let arrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "arrow_down")
        iv.contentMode = .scaleAspectFit
        return iv
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
        self.backgroundColor = .clear

        self.addSubview(self.containerView, anchors: [.fill()])

        self.addSubview(self.titleLabel, anchors: [
            .centerY(to: self.topAnchor),
            .leading(to: self.leadingAnchor, constant: 12)
        ])

        self.addSubview(self.textField, anchors: [
            .top(to: self.topAnchor, constant: 5),
            .leading(to: self.leadingAnchor, constant: 8),
            .trailing(to: self.trailingAnchor, constant: 8),
            .bottom(to: self.bottomAnchor, constant: -5)
        ])

        self.addSubview(self.arrowImageView, anchors: [
            .centerY(to: self.textField.centerYAnchor),
            .trailing(to: self.textField.trailingAnchor, constant: 10),
            .width(constant: 16.5),
            .height(constant: 8)
        ])

        self.bringSubviewToFront(self.titleLabel)
    }
}
