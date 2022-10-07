//
//  PillCell.swift
//  Boxen
//
//  Created by Simon Elhøj Steinmejer on 14/10/2021.
//

import UIKit

class PillCell: UICollectionViewCell {

    let pillImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
        self.configureAutoLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
        self.configureAutoLayout()
    }

    fileprivate func configureView() {
        self.backgroundColor = .darkGreen
        self.layer.cornerRadius = 14
        self.layer.masksToBounds = true
    }

    fileprivate func configureAutoLayout() {
        self.addSubview(self.pillImageView, anchors: [
            .top(to: self.topAnchor, constant: 22),
            .centerX(to: self.centerXAnchor),
            .height(constant: 55),
            .width(constant: 55)
        ])

        self.addSubview(self.nameLabel, anchors: [
            .top(to: self.pillImageView.bottomAnchor, constant: 20),
            .leading(to: self.leadingAnchor, constant: 12),
            .trailing(to: self.trailingAnchor, constant: 12)
        ])

        self.addSubview(self.timeLabel, anchors: [
            .top(to: self.nameLabel.bottomAnchor, constant: 5),
            .leading(to: self.leadingAnchor, constant: 12)
        ])

        self.addSubview(self.amountLabel, anchors: [
            .centerY(to: self.timeLabel.centerYAnchor),
            .trailing(to: self.trailingAnchor, constant: 12)
        ])

    }

    func configure(with pill: Pill) {
        self.pillImageView.image = UIImage(named: pill.shape)
        self.nameLabel.text = pill.name
        self.amountLabel.text = pill.dosage
        self.timeLabel.text = pill.time
    }

}
