//
//  PillCollectionCell.swift
//  Boxen
//
//  Created by Simon Elhøj Steinmejer on 14/10/2021.
//

import UIKit

protocol PillCollectionCellDelegate: AnyObject {
    func upcomingPillPressed(pill: Pill)
    func missedPillPressed(pill: Pill)
}

class PillCollectionCell: UITableViewCell {

    var type: PillCollectionType!

    var pills = [Pill]() {
        didSet {
            self.collectionView.reloadData()
        }
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.register(cell: PillCell.self)
        cv.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()

    weak var delegate: PillCollectionCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureView()
        self.configureAutoLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
        self.configureAutoLayout()
    }

    fileprivate func configureView() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }

    fileprivate func configureAutoLayout() {
        self.contentView.addSubview(self.titleLabel, anchors: [
            .leading(to: self.leadingAnchor, constant: 12),
            .top(to: self.topAnchor, constant: 8)
        ])

        self.contentView.addSubview(self.timeLabel, anchors: [
            .trailing(to: self.trailingAnchor, constant: 12),
            .top(to: self.topAnchor, constant: 8)
        ])

        self.contentView.addSubview(self.collectionView, anchors: [
            .top(to: self.titleLabel.bottomAnchor, constant: 12),
            .leading(to: self.leadingAnchor),
            .trailing(to: self.trailingAnchor),
            .bottom(to: self.bottomAnchor, constant: -16)
        ])
    }
}

extension PillCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pills.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: PillCell.self, for: indexPath)
        cell.configure(with: self.pills[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch self.type {
            case .missed:
                self.delegate?.missedPillPressed(pill: self.pills[indexPath.item])
            case .upcoming:
                self.delegate?.upcomingPillPressed(pill: self.pills[indexPath.item])
                self.pills.remove(at: indexPath.item)
                self.collectionView.reloadData()
            default: break
        }
    }
}

enum PillCollectionType {
    case missed
    case upcoming
}
