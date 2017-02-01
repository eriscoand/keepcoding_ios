//
//  Author.swift
//  HackerBook
//
//  Created by Eric Risco de la Torre on 01/02/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

class Author : Hashable  {
    
    //MARK: - Stored Properties
    let name       :   String
    
    
    //MARK: - Computed Properties
    var hashValue : Int {
        get {
            return "\(name)".hashValue
        }
    }
    
    //MARK: - Initialization
    init(name: String){
        
        self.name = name
        
    }
    
    //MARK: - Conv initialization
    
    
    //MARK: - Proxies
    func proxieForEquality() -> String{
        return "\(name)"
    }
    
    func proxieForComparison() -> String{
        return proxieForEquality()
    }
    
    //MARK: - STATIC FUNC
    static func by(s : String) -> Set<Author>{
        
        var ret = Set<Author>()
        
        let arr = s.characters.split{$0 == ","}.map(String.init)
        
        for each in arr{
            let author = Author(name: each)
            ret.insert(author)
        }
        
        return ret
        
    }
    
}

extension Author : Equatable{
    public static func ==(lhs: Author, rhs: Author) -> Bool{
        return lhs.proxieForEquality() == rhs.proxieForEquality()
    }
}

extension Author : Comparable{
    
    public static func <(lhs: Author, rhs: Author) -> Bool{
        return (lhs.proxieForComparison() < rhs.proxieForComparison())
    }
    
}

extension Author : CustomStringConvertible{
    public var description: String {
        get{
            return "[\(type(of:self))]: \(name)"
        }
    }
}
