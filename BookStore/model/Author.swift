//
//  Author.swift
//  BookStore
//
//  Created by Sebastijan Zindl on 17.2.24.
//

import Foundation

struct Author: Identifiable {
    let id = UUID()
    
    let name: String
    
    static var example  = Author(name: "Frank Herbert")
    
    static var examples: [Author] = [
        Author(name: "V.E.Schwab"),
        Author(name: "Charles Dickens"),
        Author(name: "J.K.Rowling"),
        Author(name: "Dan Brown"),
        Author(name: "Liu Cixin"),
        Author(name: "R.F. Kuang"),
        Author(name: "Frank Herbert")
    ]
}
