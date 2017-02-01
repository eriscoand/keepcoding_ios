//
//  Errors.swift
//  HackerBook
//
//  Created by Eric Risco de la Torre on 31/01/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

enum HackerBookError : Error{
    case wrongUrlFormatForJSONResource
    case resourcePointedByUrlNotReachable
    case wrongJsonFormat
    case NotInLibrary
}
