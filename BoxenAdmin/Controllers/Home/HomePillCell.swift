//
//  HomePillCell.swift
//  Boxenv2
//
//  Created by Simon Elhøj Steinmejer on 14/08/2022.
//

import UIKit

class HomePillCell: UICollectionViewCell {

    let pillImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "long")
        return iv
    }()

    let circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 21
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(red: 81/255, green: 121/255, blue: 126/255, alpha: 1)
        return view
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "11:30"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        return label
    }()


    let pillLabel: UILabel = {
        let label = UILabel()
        label.text = "Paracetamol"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 52/255, green: 77/255, blue: 80/255, alpha: 1)
        label.textAlignment = .center
        return label
    }()

    let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "500 mg"
        label.textColor = UIColor(red: 58/255, green: 86/255, blue: 90/255, alpha: 0.6)
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureAutoLayout()
        self.configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureAutoLayout()
        self.configureView()
    }

    fileprivate func configureView() {
        self.contentView.layer.cornerRadius = 36
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor(red: 100/255, green: 115/255, blue: 140/255, alpha: 1).cgColor
    }

    fileprivate func configureAutoLayout() {
        self.contentView.addSubview(self.pillImageView, anchors: [
            .top(to: self.topAnchor, constant: 22),
            .leading(to: self.leadingAnchor, constant: 20),
            .height(constant: 32),
            .width(constant: 32)
        ])

        self.contentView.addSubview(self.circleView, anchors: [
            .top(to: self.topAnchor, constant: 18),
            .trailing(to: self.trailingAnchor, constant: 12),
            .height(constant: 42),
            .width(constant: 42)
        ])

        self.circleView.addSubview(self.timeLabel, anchors: [
            .centerY(to: self.circleView.centerYAnchor),
            .centerX(to: self.circleView.centerXAnchor)
        ])

        self.contentView.addSubview(self.amountLabel, anchors: [
            .bottom(to: self.bottomAnchor, constant: -18),
            .leading(to: self.leadingAnchor, constant: 12),
            .trailing(to: self.trailingAnchor, constant: 12)
        ])

        self.contentView.addSubview(self.pillLabel, anchors: [
            .bottom(to: self.amountLabel.topAnchor, constant: -2),
            .leading(to: self.leadingAnchor, constant: 12),
            .trailing(to: self.trailingAnchor, constant: 12)
        ])
    }

}
