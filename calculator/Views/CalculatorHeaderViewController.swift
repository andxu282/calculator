//
//  CalculatorHeaderViewController.swift
//  calculator
//
//  Created by Andrew Xu on 12/11/24.
//

import UIKit

class CalculatorHeaderViewController: UICollectionReusableView{
    
    static let identifier: String = "CalculatorHeaderViewController"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 72, weight: .regular)
        label.text = "???"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    public func configure(currentCalculatorText: String) {
        self.label.text = currentCalculatorText
    }
    
    private func setupUI() {
        self.backgroundColor = .black
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            self.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: label.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
