//
//  MenuItemCell.swift
//  Boxenv2
//
//  Created by Simon Elhøj Steinmejer on 21/07/2022.
//

import UIKit

class MenuItemCell: UICollectionViewCell {

    let menuNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
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
        self.contentView.addSubview(self.menuNameLabel, anchors: [
            .height(constant: 20),
            .leading(to: self.leadingAnchor, constant: 18),
            .trailing(to: self.trailingAnchor, constant: 18),
            .centerY(to: self.centerYAnchor)
        ])
    }
}
