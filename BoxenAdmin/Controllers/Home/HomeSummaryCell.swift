//
//  HomeSummaryCell.swift
//  BoxenAdmin
//
//  Created by Simon Elhøj Steinmejer on 25/06/2022.
//

import UIKit

class HomeSummaryCell: UITableViewCell {

    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()

    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "summary_background")
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    let gradientView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: effect)
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Good afternoon, John!"
        label.textColor = UIColor(red: 67/255, green: 100/255, blue: 105/255, alpha: 1)
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    let bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let attributtedString = NSMutableAttributedString(string: "You have ", attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .light),
            .foregroundColor: UIColor(red: 67/255, green: 100/255, blue: 105/255, alpha: 1)
        ])
        attributtedString.append(NSAttributedString(string: "6 new pills ", attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold),
            .foregroundColor: UIColor(red: 67/255, green: 100/255, blue: 105/255, alpha: 1)
        ]))
        attributtedString.append(NSAttributedString(string: "to take\nfor tooday, and you ", attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .light),
            .foregroundColor: UIColor(red: 67/255, green: 100/255, blue: 105/255, alpha: 1)
        ]))
        attributtedString.append(NSAttributedString(string: "missed 2 pills.", attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold),
            .foregroundColor: UIColor(red: 67/255, green: 100/255, blue: 105/255, alpha: 1)
        ]))
        label.attributedText = attributtedString
        return label
    }()

    let progressButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 100/255, green: 115/255, blue: 140/255, alpha: 1)
        button.setTitle("View progress", for: .normal)
        button.layer.cornerRadius = 23
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.selectionStyle = .none
        self.configureView()
    }


    fileprivate func configureView() {
        self.backgroundColor = .clear
        self.contentView.addSubview(self.containerView, anchors: [.fill(padding: UIEdgeInsets(top: 8, left: 10, bottom: -8, right: 10))])
        self.containerView.addSubview(self.backgroundImageView, anchors: [.fill()])
        self.containerView.addSubview(self.gradientView, anchors: [
            .bottom(to: self.containerView.bottomAnchor),
            .leading(to: self.containerView.leadingAnchor),
            .trailing(to: self.containerView.trailingAnchor),
            .height(constant: 100)
        ])

        self.gradientView.contentView.addSubview(self.titleLabel, anchors: [
            .top(to: self.gradientView.topAnchor, constant: 18),
            .leading(to: self.gradientView.leadingAnchor, constant: 12)
        ])

        self.gradientView.contentView.addSubview(self.bodyLabel, anchors: [
            .top(to: self.titleLabel.bottomAnchor, constant: 8),
            .leading(to: self.gradientView.leadingAnchor, constant: 12)
        ])

        self.gradientView.contentView.addSubview(self.progressButton, anchors: [
            .trailing(to: self.gradientView.trailingAnchor, constant: 12),
            .top(to: self.gradientView.topAnchor, constant: 28),
            .height(constant: 46),
            .width(constant: 120)
        ])
    }
}
