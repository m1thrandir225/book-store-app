//
//  Expense.swift
//  BookStore
//
//  Created by Sebastijan Zindl on 17.2.24.
//

import Foundation

struct Expense: Identifiable {
    
    let id: UUID
    let title: String;
    let amount: Double;
    let expenseDate: Date;
    let category: ExpenseCategory
    
    static var example = Expense(id: UUID(), title: "Rent", amount: 2000, expenseDate: Date(timeIntervalSinceNow: -7_200_000), category: .fixed)
    
    static var examples: [Expense] = [
        Expense(id: UUID(), title: "Rent", amount: 2000, expenseDate: Date(timeIntervalSinceNow: -7_200_000), category: .fixed),
        Expense(id: UUID(), title: "Salaries", amount: 5000, expenseDate: Date(timeIntervalSinceNow: -14_200_000), category: .fixed),
        Expense(id: UUID(), title: "Marketing", amount: 8000, expenseDate: Date(timeIntervalSinceNow: -21_200_000), category: .variable),
        Expense(id: UUID(), title: "Inventory", amount: 10000, expenseDate: Date(timeIntervalSinceNow: -24_200_000), category: .fixed),
        Expense(id: UUID(), title: "Utilities", amount: 12000, expenseDate: Date(timeIntervalSinceNow: -32_200_000), category: .variable),
    ]
    
    static var yearExamples: [Expense] = {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy/MM/dd"
        var expenses = [Expense]()
        
        for month in 1...12 {
            for _ in 1...10 {
                let randomDay = Int.random(in: 1...28)
                let date = formater.date(from: "2023/\(month)/\(randomDay)")!
                let category: ExpenseCategory = Bool.random() ? .fixed : .variable
                let title = category == .fixed ? "Rent" : "Supplies"
                let amount: Double = category == .fixed ? 2000 : Double.random(in: 100...500)
                expenses.append(Expense(id: UUID(), title: title, amount: amount, expenseDate: date, category: category))
            }
        }
        return expenses
    }()
}

enum ExpenseCategory {
    case fixed
    case variable
    
    var displayName: String {
        switch self {
        case .fixed:
            "Fixed"
        case .variable:
            "Variable"
        }
    }
}
