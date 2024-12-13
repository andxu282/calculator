//
//  CalculatorButtonViewModel.swift
//  calculator
//
//  Created by Andrew Xu on 12/13/24.
//

import UIKit

enum CalculatorButton {
    case allClear
    case plusMinus
    case percentage
    case divide
    case multiply
    case subtract
    case add
    case equals
    case decimal
    case number(Int)
    
    init (calculatorButton: CalculatorButton) {
        switch calculatorButton {
        case .allClear, .plusMinus, .percentage, .divide, .multiply, .subtract, .add, .equals, .decimal:
            self = calculatorButton
        case .number(let int):
            if int >= 0 && int <= 9 {
                self = .number(int)
            } else {
                fatalError( "Invalid number \(int)")
            }
        }
    }
}

extension CalculatorButton {
    var title: String {
        switch self {
        case .allClear: return "AC"
        case .plusMinus: return "+/-"
        case .percentage: return "%"
        case .divide: return "÷"
        case .multiply: return "x"
        case .subtract: return "-"
        case .add: return "+"
        case .equals: return "="
        case .decimal: return "."
        case .number(let int): return int.description
        }
    }
    
    var color: UIColor {
        switch self {
        case .allClear, .plusMinus, .percentage:
            return .lightGray
        case .divide, .multiply, .subtract, .add, .equals:
            return .systemOrange
        default:
            return .darkGray
        }
    }
    
    var selectedColor: UIColor? {
        switch self {
        case .divide, .multiply, .subtract, .add, .equals:
            return .white
        default:
            return nil
        }
    }
}
