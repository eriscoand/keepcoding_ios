//
//  Library.swift
//  HackerBook
//
//  Created by Eric Risco de la Torre on 31/01/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import UIKit

class Library{
    
    typealias BookArray = [Book]
    typealias TagArray = [Tag]
    
    typealias BookSet = Set<Book>
    typealias TagSet = Set<Tag>
    
    typealias BooksDictionary = MultiDictionary<Tag, Book>
    
    var books : BookSet
    var tags : TagSet
    var dict : BooksDictionary
    
    init(books: BookSet,
         tags: TagSet){
        
        self.books = books
        self.tags = tags
        self.dict = BooksDictionary()
        
        dict = self.makeEmptyTagsBooks(tags: tags)
        
        print(tags.count)
        
        for tag in tags{
            
            var booksToInsert = BookSet()
            
            for book in books{
                for tagInBook in book.tags{
                    if(tagInBook == tag){
                        booksToInsert.insert(book)
                    }
                }
            }
            
            dict[tag] = booksToInsert
            
        }
        
    }
    
    
    var tagCount : Int{
        get{
            return dict.count
        }
    }
    
    func bookCount(forTag tag: Tag) -> Int{
        guard let count = dict[tag]?.count else{
            return 0
        }
        
        return count
    }
    
    func books(forTag tag: Tag) throws -> BookSet?{
        
        guard let books = dict[tag] else{
            throw HackerBookError.NotInLibrary
        }
        
        return books
        
    }
    
    func book(atIndex index: Int, forTag tag: Tag) throws -> Book? {
        
        guard let books = dict[tag] else{
            throw HackerBookError.NotInLibrary
        }
        
        let book = books[books.index(books.startIndex, offsetBy: index)]
        return book
        
    }
    
    func tagName(_ tag: Tag) -> String{
        return tag.name
    }
    
    func makeEmptyTagsBooks(tags: TagSet) -> BooksDictionary{
        
        var d = BooksDictionary()
        
        for tag in tags{
            d[tag] = BookSet()
        }
        
        return d
        
    }
    
}
