//
//  Book.swift
//  BookStore
//
//  Created by Sebastijan Zindl on 17.2.24.
//

import Foundation

struct Book: Identifiable, Equatable {
    let id: UUID;
    let title: String;
    let author: Author;
    let category: BookCategory;
    let price: Double
    let inventoryCount: Int
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        lhs.id == rhs.id
    }
    
    static var example = Book(id: UUID(),
                              title: "Dune",
                              author: Author.example,
                              category: BookCategory.fantasy,
                              price: 10.50,
                              inventoryCount: 50);
    
    static var examples: [Book] = [
        Book(
            id: UUID(), title: "A Gathering of Shadows", author: Author.examples[0], category: .fantasy, price: 15.99, inventoryCount: 120
        ),
        Book(id: UUID(), title: "Oliver Twist", author: Author.examples[1], category: .children, price: 9.99, inventoryCount: 450),
        Book(id: UUID(), title: "Harry Potter And The Goblet Of Fire", author: Author.examples[2], category: .fantasy, price: 12.99, inventoryCount: 300),
        Book(id: UUID(), title: "The Tree Body Problem", author: Author.examples[4], category: .fantasy, price: 12.99, inventoryCount: 90)
    ]
}
