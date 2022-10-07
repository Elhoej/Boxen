//
//  DayCell.swift
//  Boxen
//
//  Created by Simon Elhøj Steinmejer on 28/10/2021.
//

import UIKit

class DayCell: UICollectionViewCell {

    override var isSelected: Bool {
        didSet {
            self.backgroundColor = self.isSelected ? .darkGreen : .lightGreen
        }
    }

    let dayLabel: UILabel = {
        let label = UILabel()
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
        self.backgroundColor = .lightGreen
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4 / 2.0
        self.addSubview(self.dayLabel, anchors: [
            .fill()
        ])
    }

    func configure(with day: String) {
        self.dayLabel.text = day
    }
}
