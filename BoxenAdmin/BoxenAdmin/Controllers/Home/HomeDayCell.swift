//
//  DayCell.swift
//  Boxenv2
//
//  Created by Simon Elhøj Steinmejer on 13/08/2022.
//

import UIKit

protocol HomeDayCellDelegate: AnyObject {
    func didSelect()
}

class HomeDayCell: UITableViewCell {

    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "08:00 AM"
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        return label
    }()

    let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.layer.masksToBounds = true
        return view
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(cell: HomePillCell.self)
        cv.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()

    weak var delegate: HomeDayCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureAutoLayout()
        self.configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureAutoLayout()
        self.configureView()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineDashPattern = [2, 2] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 14, y: 36), CGPoint(x: 14, y: 234)])
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }

    fileprivate func configureView() {
        self.selectionStyle = .none
    }

    fileprivate func configureAutoLayout() {

        self.contentView.addSubview(self.circleView, anchors: [
            .top(to: self.topAnchor, constant: 16),
            .leading(to: self.leadingAnchor, constant: 8),
            .height(constant: 12),
            .width(constant: 12)
        ])

        self.contentView.addSubview(self.timeLabel, anchors: [
            .top(to: self.topAnchor, constant: 12),
            .leading(to: self.leadingAnchor, constant: 44)
        ])

        self.contentView.addSubview(self.collectionView, anchors: [
            .top(to: self.timeLabel.bottomAnchor, constant: 14),
            .leading(to: self.leadingAnchor, constant: 16),
            .trailing(to: self.trailingAnchor),
            .bottom(to: self.bottomAnchor, constant: -8)
        ])
    }

}

extension HomeDayCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: HomePillCell.self, for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 166, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelect()
    }


}
