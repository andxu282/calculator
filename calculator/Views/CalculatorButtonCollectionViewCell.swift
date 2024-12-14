//
//  CalculatorButtonCollectionViewCell.swift
//  calculator
//
//  Created by Andrew Xu on 12/11/24.
//

import UIKit

class CalculatorButtonCollectionViewCell: UICollectionViewCell {
    static let identifier = "CalculatorButtonCollectionViewCell"
    var calculatorButton: CalculatorButton? {
        didSet {
            self.titleLabel.text = calculatorButton?.title
            self.backgroundColor = calculatorButton?.color
            switch calculatorButton {
            case .allClear, .plusMinus, .percentage:
                self.titleLabel.textColor = .black
            default:
                self.titleLabel.textColor = .white
            }
            self.setupUI()
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .regular)
        label.textAlignment = .center
        label.text = "?"
        return label
    }()
    
    public func configure(with calculatorButton: CalculatorButton) {
        self.calculatorButton = calculatorButton
    }
    
    private func setupUI() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = self.frame.height / 2
        switch self.calculatorButton {
        case .number(0):
            NSLayoutConstraint.activate([
                titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
                titleLabel.widthAnchor.constraint(equalToConstant: self.frame.height)
            ])
        default:
            NSLayoutConstraint.activate([
                titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
                titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
            ])
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.removeFromSuperview()
    }
}
