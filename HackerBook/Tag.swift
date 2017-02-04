//
//  Tag.swift
//  HackerBook
//
//  Created by Eric Risco de la Torre on 31/01/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

class Tag : Hashable  {
    
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
    
    //MARK: - Static functions
    //from a string it returns a Set of Tags
    static func fromStringToSet(s : String) -> Set<Tag>{
        var ret = Set<Tag>()
        let arr = s.characters.split{$0 == ","}.map(String.init)
        for each in arr{
            let tag = Tag(name: each.trimmingCharacters(in: .whitespacesAndNewlines).capitalized)
            ret.insert(tag)
        }
        return ret
    }
    
    //from a set it returns a sorted array of tags. It also adds the favourite tag in the first position
    static func fromSetToArray(s: Set<Tag>) -> [Tag]{
        
        var ret = [Tag]()
        let favouriteTag = Tag.init(name: CONSTANTS.FAVOURITES_NAME)
        ret.append(favouriteTag)
        
        //Ordered!!
        for tag in s.sorted(by: { (s1: Tag, s2: Tag) -> Bool in return s1 < s2 }){
            ret.append(tag)
        }
        
        return ret
    }
    
}

//MARK: - Extensions
extension Tag : Equatable{
    public static func ==(lhs: Tag, rhs: Tag) -> Bool{
        return lhs.proxieForEquality() == rhs.proxieForEquality()
    }
}

extension Tag : Comparable{
    
    public static func <(lhs: Tag, rhs: Tag) -> Bool{
        return (lhs.proxieForComparison() < rhs.proxieForComparison())
    }
    public static func >(lhs: Tag, rhs: Tag) -> Bool{
        return (lhs.proxieForComparison() > rhs.proxieForComparison())
    }
    
}

extension Tag : CustomStringConvertible{
    public var description: String {
        get{
            return "[\(type(of:self))]: \(name)"
        }
    }
}
