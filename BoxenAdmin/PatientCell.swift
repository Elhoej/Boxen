//
//  PatientCell.swift
//  BoxenAdmin
//
//  Created by Simon Elhøj Steinmejer on 17/11/2021.
//

import UIKit

class PatientCell: UITableViewCell {

    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.32, green: 0.47, blue: 0.49, alpha: 1.00)
        view.layer.cornerRadius = 8
        return view
    }()

    let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 25
        iv.backgroundColor = UIColor(red: 0.70, green: 0.78, blue: 0.79, alpha: 1.00)
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear

        self.addSubview(self.bgView, anchors: [
            .fill(padding: .init(top: 3, left: 10, bottom: -3, right: 10))
        ])

        self.bgView.addSubview(self.avatarImageView, anchors: [
            .leading(to: self.bgView.leadingAnchor, constant: 8),
            .centerY(to: self.bgView.centerYAnchor),
            .height(constant: 50),
            .width(constant: 50)
        ])

        self.bgView.addSubview(self.nameLabel, anchors: [
            .top(to: self.bgView.topAnchor, constant: 10),
            .leading(to: self.avatarImageView.trailingAnchor, constant: 12),
            .trailing(to: self.bgView.trailingAnchor, constant: 12)
        ])

        self.bgView.addSubview(self.timeLabel, anchors: [
            .top(to: self.nameLabel.bottomAnchor, constant: 5),
            .leading(to: self.avatarImageView.trailingAnchor, constant: 12),
            .trailing(to: self.bgView.trailingAnchor, constant: 12)
        ])
    }

    func configure(with pill: Pill) {
        self.nameLabel.text = pill.name
        self.timeLabel.text = "\(pill.dosage)\n\(pill.time)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
