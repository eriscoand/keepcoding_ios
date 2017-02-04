//
//  Favourites.swift
//  HackerBook
//
//  Created by Eric Risco de la Torre on 03/02/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

//Favourite persist - We use Standard UserDefaults. We only save the hashValue of a book (an int generated from the title)
class Favourites {
    
    //Add a book to the favourite list
    static func addFavourite(b: Book) {
        let defaults = UserDefaults.standard
        var books = defaults.object(forKey: CONSTANTS.FAVOURITES_NAME) as? [Int] ?? [Int]()
        
        books.append(b.hashValue)
       
        defaults.set(books, forKey: CONSTANTS.FAVOURITES_NAME)
    }
    
    //Delete a book from the favourite list
    static func deleteFavourite(b: Book) {
        let defaults = UserDefaults.standard
        var books = defaults.object(forKey: CONSTANTS.FAVOURITES_NAME) as? [Int] ?? [Int]()
        
        if let i = books.index(of: b.hashValue){
            books.remove(at: i)
        }
        
        defaults.set(books, forKey: CONSTANTS.FAVOURITES_NAME)
    }
    
    //Check if a book is on the favourite list.
    static func isFavourite(b: Book) -> Bool{
        let defaults = UserDefaults.standard
        let books = defaults.object(forKey: CONSTANTS.FAVOURITES_NAME) as? [Int] ?? [Int]()
        
        if books.contains(b.hashValue){
            return true
        }else{
            return false
        }
    }
    
    
}
