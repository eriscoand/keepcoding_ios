//
//  Book.swift
//  HackerBook
//
//  Created by Eric Risco de la Torre on 31/01/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import UIKit

class Book : Hashable {
    
    //MARK: - Stored Properties
    let title       :   String
    let authors     :   Set<Author>
    let tags        :   Set<Tag>
    let thumbnail   :   UIImage
    let pdf         :   Data
    var isFavourite :   Bool
    
    
    //MARK: - Computed Properties
    var hashValue : Int {
        get {
            return "\(title)".hashValue
        }
    }
    
    
    //MARK: - Initialization
    init(title: String,
         authors: Set<Author>,
         tags: Set<Tag>,
         thumbnail: UIImage,
         pdf: Data,
         isFavourite: Bool){
        
        self.title = title
        self.authors = authors
        self.tags = tags
        self.thumbnail = thumbnail
        self.pdf = pdf
        self.isFavourite = isFavourite        
        
    }
    
    //MARK: - Conv initialization
    
    
    //MARK: - Proxies
    func proxieForEquality() -> String{
        return "\(title)"
    }
    
    func proxieForComparison() -> String{
        return proxieForEquality()
    }
    
    //MARK: - STATIC FUNC    
    static func from(array arr: [Book]) -> Set<Book>{
        var ret = Set<Book>()
        
        for book in arr{
            ret.insert(book)
        }
        
        return ret        
    }
    
}

extension Book : Equatable{
    public static func ==(lhs: Book, rhs: Book) -> Bool{
        return lhs.proxieForEquality() == rhs.proxieForEquality()
    }
}

extension Book : Comparable{
    
    public static func <(lhs: Book, rhs: Book) -> Bool{
        return (lhs.proxieForComparison() < rhs.proxieForComparison())
    }
    
}

extension Book : CustomStringConvertible{
    public var description: String {
        get{
            return "[\(type(of:self))]: \(title)"
        }
    }
}
