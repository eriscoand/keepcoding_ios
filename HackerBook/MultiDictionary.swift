//
//  MultiDictionary.swift
//  HackerBook
//
//  Created by Eric Risco de la Torre on 31/01/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public struct MultiDictionary<Key: Hashable, Value: Hashable>{
    
    //MARK: - Types
    public
    typealias Bucket = Set<Value>
    
    //MARK: - Properties
    private
    var _dict : [Key : Bucket]
    
    //MARK: - Lifecycle
    public
    init(){
        _dict = Dictionary()
    }
    
    //MARK: - Accessors
    public
    var isEmpty: Bool{
        return _dict.isEmpty
    }
    
    public
    var countBuckets : Int{
        return _dict.count
    }
    
    public
    var count : Int{
        var total = 0
        for bucket in _dict.values{
            total += bucket.count
        }
        return total
    }
    
    public
    var countUnique : Int{
        var total = Bucket()
        
        for bucket in _dict.values{
            total = total.union(bucket)
        }
        return total.count
    }
    
    //MARK: - Setters (Mutators)
    public
    subscript(key: Key) -> Bucket?{
        get{
            return _dict[key]
        }
        
        set(maybeNewBucket){
            guard let newBucket = maybeNewBucket else{
                return
            }
            
            guard let previous = _dict[key] else{
                _dict[key] = Bucket()
                return
            }
            
            _dict[key] = previous.union(newBucket)
        }
    }
    
    public
    mutating func insert(value: Value, forKey key: Key){
        
        if var previous = _dict[key]{
            previous.insert(value)
            _dict[key] = previous
        }else{
            _dict[key] = [value]
        }
    }
    
}
