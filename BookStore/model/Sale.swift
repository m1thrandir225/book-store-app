//
//  Sale.swift
//  BookStore
//
//  Created by Sebastijan Zindl on 17.2.24.
//

import Foundation

struct Sale: Identifiable, Equatable {
    let id: UUID
    let book: Book;
    let quantity: Int;
    let saleDate: Date
    
    static func == (lhs: Sale, rhs: Sale) -> Bool {
        lhs.id == rhs.id
    }
    
    static var example = Sale(id: UUID(), book: Book.examples[0], quantity: 5, saleDate: Date(timeIntervalSinceNow: -7_200_000))
    
    static var examples: [Sale] = [
        Sale(id: UUID(), book: Book.examples[1], quantity: 3, saleDate: Date(timeIntervalSinceNow: -7_400_000)),
        Sale(id: UUID(), book: Book.examples[0], quantity: 8, saleDate: Date(timeIntervalSinceNow: -9_200_000)),
        Sale(id: UUID(), book: Book.examples[2], quantity: 2, saleDate: Date(timeIntervalSinceNow: -10_550_000)),
        Sale(id: UUID(), book: Book.examples[1], quantity: 12, saleDate: Date(timeIntervalSinceNow: -15_800_000)),
        Sale(id: UUID(), book: Book.examples[3], quantity: 25, saleDate: Date(timeIntervalSinceNow: -22_100_000)),
        Sale(id: UUID(), book: Book.examples[1], quantity: 1, saleDate: Date(timeIntervalSinceNow: -24_300_000)),
    ]
    
    static func threeMonthsExample() -> [Sale] {
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!
        
        let exampleSales: [Sale] = (1...300).map { _ in
            let randomBook = Book.examples.randomElement()!
            let randomQuantity = Int.random(in: 1...5)
            let randomDate = Date.random(in: threeMonthsAgo...Date())
            
            return Sale(id: UUID(), book: randomBook, quantity: randomQuantity, saleDate: randomDate)
        }
        
        return exampleSales.sorted { $0.saleDate < $1.saleDate }
    }
}


extension Date {
    static func random(in range: ClosedRange<Date>) -> Date {
        let diff = range.upperBound.timeIntervalSinceReferenceDate - range.lowerBound.timeIntervalSinceReferenceDate
        let randomvalue = diff * Double.random(in: 0...1) + range.lowerBound.timeIntervalSinceReferenceDate
        return Date(timeIntervalSinceReferenceDate: randomvalue)
    }
}
