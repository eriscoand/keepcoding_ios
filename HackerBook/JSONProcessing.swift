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


//MARK: - Functions
func decodeBook(book json: JSONDictonary) throws -> Book {
    
    var image = Data()
    
    guard let urlImageString = json["image_url"] as? String else{
        throw HackerBookError.wrongJsonFormat
    }
    
    if (!fileAlreadyExists(stringUrl: urlImageString)){
        image = try saveToLocalStorage(stringUrl: urlImageString)
    }else{
        image = try dataFromStringUrl(stringUrl: urlImageString)
    }

    let defaultPDFURLString = "bacon_ipsum.pdf"
    guard let defaultPDFURL = Bundle.main.url(forResource: defaultPDFURLString),
        let pdf = try? Data(contentsOf: defaultPDFURL) else{
            throw HackerBookError.resourcePointedByUrlNotReachable
    }

    guard let title = json["title"] as? String else{
        throw HackerBookError.wrongJsonFormat
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
                pdf: pdf)
    
}

func decodeBooks(books json: JSONArray) throws -> Set<Book>{
    
    let bookArray = try json.flatMap({try decodeBook(book: $0)})
    
    return Book.from(array: bookArray)
    
}

func decodeTags(forBooks books: Set<Book>) throws -> Set<Tag>{
    
    var tags = Set<Tag>()
    
    for book in books{
        for tag in book.tags{
            tags.insert(tag)
        }
    }
    
    return tags
    
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


