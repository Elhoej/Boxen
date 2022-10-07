//
//  CreatePillViewController.swift
//  Boxen
//
//  Created by Simon Elhøj Steinmejer on 16/10/2021.
//

import UIKit
import DropDown
import MustacheUIKit

class CreatePillViewController: UIViewController {

    let shapeLabel: UILabel = {
        let label = UILabel()
        label.text = "Pill's shape"
        return label
    }()

    lazy var pillCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(cell: PillShapeCell.self)
        cv.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return cv
    }()

    lazy var dayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.allowsMultipleSelection = true
        cv.register(cell: DayCell.self)
        cv.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return cv
    }()

    let nameTextField: PillTextField = {
        let tf = PillTextField()
        tf.title = "Name"
        tf.placeholder = "Medicine name"
        tf.showImage = false
        return tf
    }()

    let timeTextField: PillTextField = {
        let tf = PillTextField()
        tf.title = "Period and time"
        tf.placeholder = "once"
        tf.showImage = false
        return tf
    }()

    lazy var timeUnitTextField: PillTextField = {
        let tf = PillTextField()
        tf.title = "per"
        tf.placeholder = "Day"
        tf.showImage = true
        tf.textField.delegate = self
        return tf
    }()

    lazy var timeDropDown: DropDown = {
        let dp = DropDown(anchorView: self.timeUnitTextField)
        dp.bottomOffset = CGPoint(x: 0, y: 48)
        dp.dataSource = self.timeUnits
        dp.direction = .bottom
        return dp
    }()

    let dosageTextField: PillTextField = {
        let tf = PillTextField()
        tf.title = "Dosage"
        tf.placeholder = "500"
        tf.showImage = false
        tf.textField.keyboardType = .decimalPad
        return tf
    }()

    lazy var dosageUnitTextField: PillTextField = {
        let tf = PillTextField()
        tf.title = "units"
        tf.placeholder = "mg"
        tf.showImage = true
        tf.textField.delegate = self
        return tf
    }()

    lazy var dosageDropDown: DropDown = {
        let dp = DropDown(anchorView: self.dosageUnitTextField)
        dp.bottomOffset = CGPoint(x: 0, y: 48)
        dp.dataSource = self.dosageUnits
        dp.direction = .bottom
        return dp
    }()

    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Which day should you take the medicin?"
        label.textAlignment = .center
        return label
    }()

    let createButton: Button = {
        let button = Button(type: .system)
        button.setTitle("Create pill", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGreen
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(createPill), for: .touchUpInside)
        return button
    }()

    var selectedDays = [String]()
    let days = ["Man", "Tir", "Ons", "Tor", "Fre", "Lør", "Søn"]
    let timeUnits = ["Day", "Week", "Month"]
    let dosageUnits = ["mg", "shot", "pack", "stripe", "piece", "tab", "ml", "tbsp", "tsp"]
    let shapes: [PillShape] = [.long, .oval, .rectangle, .round, .square, .tabs, .liquid, .syringe]
    var selectedShapeIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureAutoLayout()
    }

    fileprivate func configureView() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(close))
        self.navigationItem.title = "New pill"
        self.view.backgroundColor = .white

        self.timeDropDown.selectionAction = { (index, item) in
            self.timeUnitTextField.textField.text = item
        }

        self.dosageDropDown.selectionAction = { (index, item) in
            self.dosageUnitTextField.textField.text = item
        }
    }

    fileprivate func configureAutoLayout() {
        self.view.addSubview(self.shapeLabel, anchors: [
            .top(to: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            .leading(to: self.view.leadingAnchor, constant: 12)
        ])

        self.view.addSubview(self.pillCollectionView, anchors: [
            .top(to: self.shapeLabel.bottomAnchor, constant: 8),
            .leading(to: self.view.leadingAnchor),
            .trailing(to: self.view.trailingAnchor),
            .height(constant: 78)
        ])

        self.view.addSubview(self.nameTextField, anchors: [
            .top(to: self.pillCollectionView.bottomAnchor, constant: 32),
            .leading(to: self.view.leadingAnchor, constant: 18),
            .trailing(to: self.view.trailingAnchor, constant: 18),
            .height(constant: 48)
        ])

        let timeStackView = UIStackView(arrangedSubviews: [timeTextField, timeUnitTextField])
        timeStackView.spacing = 10
        timeStackView.distribution = .fillEqually
        timeStackView.axis = .horizontal

        let dosageStackView = UIStackView(arrangedSubviews: [dosageTextField, dosageUnitTextField])
        dosageStackView.spacing = 10
        dosageStackView.distribution = .fillEqually
        dosageStackView.axis = .horizontal

        let vStackView = UIStackView(arrangedSubviews: [timeStackView, dosageStackView])
        vStackView.distribution = .fillEqually
        vStackView.spacing = 16
        vStackView.axis = .vertical

        self.view.addSubview(vStackView, anchors: [
            .top(to: self.nameTextField.bottomAnchor, constant: 16),
            .leading(to: self.view.leadingAnchor, constant: 18),
            .trailing(to: self.view.trailingAnchor, constant: 18),
            .height(constant: 112)
        ])

        self.view.addSubview(self.dayLabel, anchors: [
            .top(to: vStackView.bottomAnchor, constant: 18),
            .leading(to: self.view.leadingAnchor, constant: 20),
            .trailing(to: self.view.trailingAnchor, constant: 20)
        ])

        self.view.addSubview(self.dayCollectionView, anchors: [
            .top(to: self.dayLabel.bottomAnchor, constant: 16),
            .leading(to: self.view.leadingAnchor),
            .trailing(to: self.view.trailingAnchor),
            .height(constant: 50)
        ])

        self.view.addSubview(self.createButton, anchors: [
            .bottom(to: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            .leading(to: self.view.leadingAnchor, constant: 20),
            .trailing(to: self.view.trailingAnchor, constant: 20),
            .height(constant: 56)
        ])
    }

    @objc fileprivate func createPill() {

        self.createButton.isBusy = true
        let dispatchGroup = DispatchGroup()

        let times = Int(self.timeTextField.textField.text ?? "") ?? 1

        switch times {
            case 1:
                dispatchGroup.enter()
                self.savePill(time: "12:00", dispatchGroup: dispatchGroup)
            case 2:
                dispatchGroup.enter()
                self.savePill(time: "10:00", dispatchGroup: dispatchGroup)
                dispatchGroup.enter()
                self.savePill(time: "18:00", dispatchGroup: dispatchGroup)
            case 3:
                dispatchGroup.enter()
                self.savePill(time: "08:00", dispatchGroup: dispatchGroup)
                dispatchGroup.enter()
                self.savePill(time: "14:00", dispatchGroup: dispatchGroup)
                dispatchGroup.enter()
                self.savePill(time: "20:00", dispatchGroup: dispatchGroup)
            default: break
        }

        dispatchGroup.notify(queue: .main) {
            self.createButton.isBusy = false
            let alert = UIAlertController(title: "You have successfully created your pill!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
                NotificationCenter.default.post(name: NSNotification.Name("refresh"), object: nil)
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    fileprivate func savePill(time: String, dispatchGroup: DispatchGroup) {
        guard let user = User.current() else { return }
        let pill = Pill()
        pill.name = self.nameTextField.textField.text ?? ""
        pill.timeList = self.selectedDays
        pill.user = user
        pill.shape = self.shapes[self.selectedShapeIndexPath?.item ?? 0].rawValue
        pill.dosage = "\(self.dosageTextField.textField.text ?? "") \(self.dosageUnitTextField.textField.text ?? "")"
        pill.timesADay = Int(self.timeTextField.textField.text ?? "") ?? 1
        pill.time = time

        pill.saveInBackground { completed, error in
            dispatchGroup.leave()
        }
    }

    @objc fileprivate func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreatePillViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case self.pillCollectionView: return self.shapes.count
            case self.dayCollectionView: return self.days.count
            default: fatalError()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            case self.pillCollectionView:
                let cell = collectionView.dequeue(cell: PillShapeCell.self, for: indexPath)
                cell.configure(with: self.shapes[indexPath.item])
                return cell
            case self.dayCollectionView:
                let cell = collectionView.dequeue(cell: DayCell.self, for: indexPath)
                cell.configure(with: self.days[indexPath.item])
                return cell
            default: fatalError()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
            case self.pillCollectionView: return CGSize(width: 70, height: 70)
            case self.dayCollectionView: return CGSize(width: 44, height: 44)
            default: fatalError()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch collectionView {
            case self.pillCollectionView:
                let cell = collectionView.cellForItem(at: indexPath)
                if let previousCellIndex = self.selectedShapeIndexPath {
                    let previousCell = collectionView.cellForItem(at: previousCellIndex)
                    previousCell?.isSelected = false
                }
                cell?.isSelected = true
                self.selectedShapeIndexPath = indexPath
            case self.dayCollectionView:
                let day = self.days[indexPath.item]
                let cell = collectionView.cellForItem(at: indexPath)
                if self.selectedDays.contains(day) {
                    self.selectedDays.remove(element: day)
                    cell?.isSelected = false
                } else {
                    cell?.isSelected = true
                    self.selectedDays.append(day)
                }
            default: fatalError()
        }
    }
}

extension CreatePillViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
            case self.timeUnitTextField.textField:
                self.timeDropDown.show()
                return false
            case self.dosageUnitTextField.textField:
                self.dosageDropDown.show()
                return false
            default: break
        }

        return true
    }
}
