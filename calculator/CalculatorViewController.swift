//
//  ViewController.swift
//  calculator
//
//  Created by Andrew Xu on 12/11/24.
//

import UIKit

class CalculatorViewController: UIViewController {
    let viewModel: CalculatorViewModel
    
    // MARK: - CollectionView
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.register(CalculatorHeaderViewController.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: CalculatorHeaderViewController.identifier)
        collectionView.register(CalculatorButtonCollectionViewCell.self,
                                forCellWithReuseIdentifier: CalculatorButtonCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    init(_ viewModel: CalculatorViewModel = CalculatorViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func setupUI() {
        self.view.addSubview(collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension CalculatorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalculatorHeaderViewController.identifier, for: indexPath) as? CalculatorHeaderViewController else { fatalError("Failed to dequeue header cell") }
        header.configure(currentCalculatorText: self.viewModel.calculatorHeaderLabel)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let totalCellHeight = view.frame.size.width
        let totalVerticalSpacing = CGFloat(40)
        
        let window = view.window?.windowScene?.keyWindow
        let topPadding = window?.safeAreaInsets.top ?? 0
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0
        
        let availableScreenHeight = view.frame.size.height - topPadding - bottomPadding
        let headerHeight = availableScreenHeight - totalVerticalSpacing - totalCellHeight
        
        return CGSize(width: view.frame.width, height: headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.calculatorButtons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalculatorButtonCollectionViewCell.identifier, for: indexPath) as? CalculatorButtonCollectionViewCell else { fatalError("Failed to dequeue button cell") }
        cell.configure(with: self.viewModel.calculatorButtons[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let calculatorButton = self.viewModel.calculatorButtons[indexPath.item]
        switch calculatorButton {
        case .number(0):
            return CGSize(width: view.frame.width / 5.0 * 2.0 + (view.frame.width / 5.0 / 3.0) - 0.01, height: view.frame.width / 5)
        default:
            return CGSize(width: view.frame.width / 5, height: view.frame.width / 5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(view.frame.width / 5 / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let calculatorButton = self.viewModel.calculatorButtons[indexPath.item]
        print(calculatorButton.title)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

