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
    
    //MARK: - Typealias
    typealias BookArray = [Book]
    typealias TagArray = [Tag]
    typealias BookSet = Set<Book>
    typealias TagSet = Set<Tag>
    typealias BooksDictionary = MultiDictionary<Tag, Book>
    
    //MARK: - Stored Properties
    var books : BookSet
    var tags : TagArray
    var dict : BooksDictionary
    
    //MARK: - Computed Properties
    var tagCount : Int{
        get{
            return tags.count
        }
    }
    
    //MARK: - Init and load
    init(books: BookSet,
         tags: TagSet){
        
        self.books = books
        self.tags = Tag.fromSetToArray(s: tags)
        self.dict = BooksDictionary()
        
        self.loadLibrary()
        
    }
    
    func loadLibrary(){
        
        //Dict init
        dict = self.makeEmptyTagsBooks(tags: self.tags)
        
        for tag in dict.keys{
            
            var booksToInsert = BookSet()
            
            //Favourite books are saved separately, We need to check if a book is on the favourite list to add it first
            if(tag == self.tags.first){ //The firs tag in the list is the favourite tag
                for book in books{
                    if(Favourites.isFavourite(b: book)){
                        booksToInsert.insert(book)
                    }
                }
            }else{
                //for every other tag we have to check if the book has it
                for book in books{
                    for tagInBook in book.tags{
                        if(tagInBook == tag){
                            booksToInsert.insert(book)
                        }
                    }
                }
            }
            
            dict[tag] = booksToInsert //Sets de books to a tag
            
        }
        
    }
    
    //counts the number of books in a tag
    func bookCount(forTag tag: Tag) -> Int{
        guard let count = dict[tag]?.count else{
            return 0
        }
        
        return count
    }
    
    //returns de books in a tag
    func books(forTag tag: Tag) throws -> BookSet?{
        
        guard let books = dict[tag] else{
            throw HackerBookError.NotInLibrary
        }
        
        return books
        
    }
    
    //returns a book at an index and a tag
    func book(atIndex index: Int, forTag tag: Tag) throws -> Book? {
        
        guard let books = dict[tag] else{
            throw HackerBookError.NotInLibrary
        }
        
        let book = books[books.index(books.startIndex, offsetBy: index)]
        return book
        
    }
    
    //returns a tag name.
    func tagName(_ tag: Tag) -> String{
        return tag.name
    }
    
    //Dict initiallizer
    func makeEmptyTagsBooks(tags: TagArray) -> BooksDictionary{
        
        var d = BooksDictionary()
        
        for tag in tags{
            d[tag] = BookSet()
        }
        
        return d
        
    }
    
}
