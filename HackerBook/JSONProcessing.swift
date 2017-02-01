//
//  JSONProcessing.swift
//  HackerBook
//
//  Created by Eric Risco de la Torre on 31/01/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import UIKit

typealias JSONObject = AnyObject;
typealias JSONDictonary = [String: JSONObject];
typealias JSONArray = [JSONDictonary];


/*
 {
 "authors": "Allen B. Downey",
 "image_url": "http://hackershelf.com/media/cache/97/bf/97bfce708365236e0a5f3f9e26b4a796.jpg",
 "pdf_url": "http://greenteapress.com/compmod/thinkcomplexity.pdf",
 "tags": "programming, python, data structures",
 "title": "Think Complexity"
 },
 
 let title       :   String
 let authors     :   [String]
 let tags        :   Set<Tag>
 let thumbnail   :   UIImage
 let pdf         :   Data
 let isFavourite :   Bool
  
 */


//MARK: - Functions
func decodeBook(book json: JSONDictonary) throws -> Book {
    
    //guard let urlImage = json["image_url"] as? String,
    guard let urlImage = "bookicon-default.png" as? String,
          let image = UIImage(named:urlImage) else{
            throw HackerBookError.resourcePointedByUrlNotReachable
    }
    
    //guard let urlPdf = json["pdf_url"] as? String,
    guard let urlPdf = "thinkcomplexity.pdf" as? String,
        let pdfUrl = Bundle.main.url(forResource: urlPdf),
        let pdf = try? Data(contentsOf: pdfUrl) else{
            throw HackerBookError.resourcePointedByUrlNotReachable
    }
    
    var isFavourite = false
    if let fav = json["isFavourite"] as? Bool{
        isFavourite = fav
    }

    var title = ""
    if let sTitle = json["title"] as? String{
        title = sTitle
    }
    
    var authors = Set<Author>()
    if let authorsString = json["authors"] as? String{
        authors = Author.by(s: authorsString)
    }
    
    var tags = Set<Tag>()
    if let tagsString = json["tags"] as? String{
        tags = Tag.by(s: tagsString)
    }
    
    return Book(title: title,
                authors: authors,
                tags: tags,
                thumbnail: image,
                pdf: pdf,
                isFavourite: isFavourite)
    
}


func decodeBooks(books json: JSONArray) throws -> Set<Book>{
    
    let bookArray = try json.flatMap ({try decodeBook(book: $0)})
    
    return Book.from(array: bookArray)
    
}

func loadFromLocalFile(fileName name: String, bundle: Bundle = Bundle.main) throws -> JSONArray{
    
    if let url = bundle.url(forResource: name),
        let data = try? Data(contentsOf: url),
        let maybeArray = try? JSONSerialization.jsonObject(with: data,
                                                           options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONArray,
        let array = maybeArray {
        return array
    }else{
        throw HackerBookError.wrongJsonFormat
    }
    
}


