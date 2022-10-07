//
//  PillCell.swift
//  BoxenAdmin
//
//  Created by Simon Elhøj Steinmejer on 25/06/2022.
//

import UIKit

class PillCell: UICollectionViewCell {

    let pills = ["liquid", "long", "oval", "rectangle", "round", "square", "syringe", "tabs"]
    lazy var randomPill = pills.randomElement()!

    lazy var pillImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: self.randomPill)
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let pillNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Paracetamol"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "08:00"
        label.textColor = UIColor(red: 67/255, green: 100/255, blue: 105/255, alpha: 1)
        label.backgroundColor = .white
        label.layer.cornerRadius = 9
        label.layer.masksToBounds = true
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()

    let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "500mg"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(red: 190/255, green: 211/255, blue: 213/255, alpha: 1)
        return label
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        self.timeLabel.textColor = UIColor(red: 67/255, green: 100/255, blue: 105/255, alpha: 1)
        self.timeLabel.backgroundColor = .white
        self.backgroundColor = UIColor(red: 97/255, green: 124/255, blue: 127/255, alpha: 1)
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
        self.pillNameLabel.textColor = .white
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }

    func configureView() {
        self.backgroundColor = UIColor(red: 97/255, green: 124/255, blue: 127/255, alpha: 1)
        self.layer.cornerRadius = 18
        self.layer.masksToBounds = true

        self.addSubview(self.timeLabel, anchors: [
            .leading(to: self.leadingAnchor, constant: 8),
            .bottom(to: self.bottomAnchor, constant: -8),
            .height(constant: 18)
        ])

        self.addSubview(self.amountLabel, anchors: [
            .leading(to: self.trailingAnchor, constant: 8),
            .bottom(to: self.bottomAnchor, constant: -8)
        ])

        self.addSubview(self.pillNameLabel, anchors: [
            .bottom(to: self.timeLabel.topAnchor, constant: -4),
            .leading(to: self.leadingAnchor, constant: 8),
            .trailing(to: self.trailingAnchor, constant: 8),
            .height(constant: 18)
        ])

        self.addSubview(self.pillImageView, anchors: [
            .top(to: self.topAnchor, constant: 12),
            .leading(to: self.leadingAnchor, constant: 8),
            .trailing(to: self.trailingAnchor, constant: 8),
            .bottom(to: self.pillNameLabel.topAnchor, constant: -4)
        ])
    }

    func configureForMissed() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.pillNameLabel.textColor = UIColor(red: 58/255, green: 86/255, blue: 90/255, alpha: 1)
        self.timeLabel.textColor = UIColor(red: 58/255, green: 86/255, blue: 90/255, alpha: 1)
        self.timeLabel.backgroundColor = .clear
    }

}
