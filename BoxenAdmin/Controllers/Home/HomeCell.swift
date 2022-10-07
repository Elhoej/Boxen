//
//  HomeCell.swift
//  BoxenAdmin
//
//  Created by Simon Elhøj Steinmejer on 25/06/2022.
//

import UIKit

class HomeCell: UITableViewCell {

    var missed = false {
        didSet {
            self.collectionView.reloadData()
        }
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 58/255, green: 86/255, blue: 90/255, alpha: 1)
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    let chooseAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Choose all", for: .normal)
        button.setTitleColor(UIColor(red: 67/255, green: 100/255, blue: 105/255, alpha: 1), for: .normal)
        button.setImage(UIImage(named: "checkmark_icon"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return button
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(cell: PillCell.self)
        cv.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    fileprivate func configureView() {
        self.selectionStyle = .none
        self.contentView.addSubview(self.titleLabel, anchors: [
            .top(to: self.topAnchor, constant: 16),
            .leading(to: self.leadingAnchor, constant: 10)
        ])

        self.contentView.addSubview(self.chooseAllButton, anchors: [
            .top(to: self.topAnchor, constant: 16),
            .trailing(to: self.trailingAnchor, constant: 10),
            .height(constant: 20),
            .width(constant: 120)
        ])

        self.contentView.addSubview(self.collectionView, anchors: [
            .top(to: self.titleLabel.bottomAnchor, constant: 12),
            .leading(to: self.leadingAnchor, constant: 0),
            .trailing(to: self.trailingAnchor, constant: 0),
            .height(constant: 146)
        ])
    }

}

extension HomeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: PillCell.self, for: indexPath)
        if self.missed {
            cell.configureForMissed()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: 145)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }

}
