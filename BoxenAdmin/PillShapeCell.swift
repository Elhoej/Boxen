//
//  PillShapeCell.swift
//  Boxen
//
//  Created by Simon Elhøj Steinmejer on 16/10/2021.
//

import UIKit

extension UIColor {
    static let darkGreen = UIColor(hex: "#617C7F")
    static let lightGreen = UIColor(hex: "#BED3D5")
    static let darkTextColor = UIColor(hex: "#0C1212")
    static let darkestOfTheDarkGreen = UIColor(hex: "#324B4E")
}

class PillShapeCell: UICollectionViewCell {

    override var isSelected: Bool {
        didSet {
            self.backgroundColor = self.isSelected ? .darkGreen : .lightGreen
        }
    }

    let pillImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
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
        self.backgroundColor = .lightGreen
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4 / 2.0
        self.addSubview(self.pillImageView, anchors: [
            .fill(padding: UIEdgeInsets(top: 12, left: 12, bottom: -12, right: 12))
        ])
    }

    func configure(with shape: PillShape) {
        self.pillImageView.image = UIImage(named: "\(shape.rawValue)")
    }
}
