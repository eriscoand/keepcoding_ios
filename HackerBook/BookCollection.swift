//
//  BookCollection.swift
//  HackerBook
//
//  Created by Eric Risco de la Torre on 31/01/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

struct BookCollection: Hashable{
    
    var books: Set<Book> = []
    
    mutating func add(book: Book){
        if !books.contains(book){
            books.insert(book)
        }
    }
    
    mutating func remove(book: Book) -> Book?{
        let removedBook = books.remove(book)
        return removedBook
    }
    
    func getByTitle(title: String) -> [Book]?{
        let findBook = books.filter{
            $0.title == title
        }
        return findBook
    }

    var count: Int{
        get{
            return books.count
        }
    }
    
    var hashValue: Int{
        get{
            return books.hashValue
        }
    }
    
}

func ==(lhs: BookCollection, rhs: BookCollection)->Bool{
    return lhs.books == rhs.books
}
