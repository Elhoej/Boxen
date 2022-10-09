//
//  PillDetailViewController.swift
//  Boxenv2
//
//  Created by Simon Elhøj Steinmejer on 27/08/2022.
//

import UIKit
//import Charts


func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
}

class PillDetailViewController: UIViewController {

    let circleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = rgba(100, 115, 140, 1)
        view.layer.cornerRadius = 67
        view.layer.masksToBounds = true
        return view
    }()

    let pillImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "tabs")
        return iv
    }()

    let titleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = rgba(232, 237, 242, 1)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = rgba(50, 75, 78, 1)
        label.backgroundColor = .white
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true

        let attributedText = NSMutableAttributedString(string: "Paracetamol", attributes: [.foregroundColor: rgba(50, 75, 78, 1), .font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        attributedText.append(NSAttributedString(string: " 10 mg", attributes: [.foregroundColor: rgba(50, 75, 78, 1), .font: UIFont.systemFont(ofSize: 16, weight: .medium)]))
        label.attributedText = attributedText

        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.textColor = rgba(50, 75, 78, 1)
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vitae nulla volutpat, hendrerit lectus vel, tincidunt dui. Nullam id purus efficitur turpis hendrerit semper."
        label.numberOfLines = 0
        return label
    }()

    let stockImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "alert_icon_red")
        return iv
    }()

    let stockLabel: UILabel = {
        let label = UILabel()
        label.text = "Low on stock"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = rgba(134, 36, 0, 1)
        return label
    }()

    let stockView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = rgba(134, 36, 0, 1).cgColor
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()

    let stockLeadingView: UIView = {
        let view = UIView()
        view.backgroundColor = rgba(134, 36, 0, 1)
        return view
    }()

    let calendarImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "red_calendar_icon")
        return iv
    }()

//    let chart: PieChartView = {
//        let chart = PieChartView()
//        return chart
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureAutoLayout()
        self.configureView()
//        self.setDataCount(2, range: 2)
    }

//    func setDataCount(_ count: Int, range: UInt32) {
//            let entries = (0..<count).map { (i) -> PieChartDataEntry in
//                // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
//                return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
//                                         label: parties[i % parties.count],
//                                         icon: #imageLiteral(resourceName: "icon"))
//            }
//
//            let set = PieChartDataSet(entries: entries, label: "Election Results")
//            set.drawIconsEnabled = false
//            set.sliceSpace = 2
//
//
//            set.colors = ChartColorTemplates.vordiplom()
//                + ChartColorTemplates.joyful()
//                + ChartColorTemplates.colorful()
//                + ChartColorTemplates.liberty()
//                + ChartColorTemplates.pastel()
//                + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
//
//            let data = PieChartData(dataSet: set)
//
//            let pFormatter = NumberFormatter()
//            pFormatter.numberStyle = .percent
//            pFormatter.maximumFractionDigits = 1
//            pFormatter.multiplier = 1
//            pFormatter.percentSymbol = " %"
//            data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
//
//            data.setValueFont(.systemFont(ofSize: 11, weight: .light))
//            data.setValueTextColor(.black)
//
//            chartView.data = data
//            chartView.highlightValues(nil)
//        }

    fileprivate func configureView() {
        self.view.backgroundColor = .white
    }

    fileprivate func configureAutoLayout() {

        self.view.addSubview(self.titleBackgroundView, anchors: [
            .top(to: self.view.topAnchor, constant: 110),
            .leading(to: self.view.leadingAnchor, constant: 18),
            .trailing(to: self.view.trailingAnchor, constant: 18),
            .height(constant: 200)
        ])

        self.view.addSubview(self.circleBackgroundView, anchors: [
            .top(to: self.view.topAnchor, constant: 32),
            .centerX(to: self.view.centerXAnchor),
            .height(constant: 134),
            .width(constant: 134)
        ])

        self.circleBackgroundView.addSubview(self.pillImageView, anchors: [
            .fill(padding: UIEdgeInsets(top: 24, left: 24, bottom: -24, right: 24))
        ])

        self.view.addSubview(self.titleLabel, anchors: [
            .top(to: self.circleBackgroundView.bottomAnchor, constant: 16),
            .height(constant: 40),
            .centerX(to: self.view.centerXAnchor)
        ])

        self.view.addSubview(self.descriptionLabel, anchors: [
            .top(to: self.titleLabel.bottomAnchor, constant: 8),
            .leading(to: self.titleBackgroundView.leadingAnchor, constant: 24),
            .trailing(to: self.titleBackgroundView.trailingAnchor, constant: 24),
            .bottom(to: self.titleBackgroundView.bottomAnchor, constant: -12)
        ])

        self.view.addSubview(self.stockImageView, anchors: [
            .top(to: self.titleBackgroundView.bottomAnchor, constant: 26),
            .leading(to: self.view.leadingAnchor, constant: 18),
            .height(constant: 18),
            .width(constant: 18)
        ])

        self.view.addSubview(self.stockLabel, anchors: [
            .leading(to: self.stockImageView.trailingAnchor, constant: 10),
            .centerY(to: self.stockImageView.centerYAnchor)
        ])

        self.view.addSubview(self.stockView, anchors: [
            .top(to: self.stockLabel.bottomAnchor, constant: 14),
            .leading(to: self.view.leadingAnchor, constant: 21),
            .trailing(to: self.view.trailingAnchor, constant: 21),
            .height(constant: 42)
        ])

        self.stockView.addSubview(self.stockLeadingView, anchors: [
            .top(to: self.stockView.topAnchor),
            .leading(to: self.stockView.leadingAnchor),
            .bottom(to: self.stockView.bottomAnchor),
            .width(constant: 6)
        ])

        self.stockView.addSubview(self.calendarImageView, anchors: [
            .top(to: self.stockView.topAnchor, constant: 10),
            .leading(to: self.stockView.leadingAnchor, constant: 22),
            .height(constant: 20),
            .width(constant: 22)
        ])

//        self.view.addSubview(self.chart, anchors: [
//            .top(to: self.stockView.bottomAnchor, constant: 20),
//            .centerX(to: self.view.center),
//            .height(constant: 100),
//            .width(constant: 100)
//        ])
    }

}
