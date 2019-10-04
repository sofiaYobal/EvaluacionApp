//
//  SuperHeroeModel.swift
//  EvaluacionApp
//
//  Created by Sofia Yobal Castro on 9/30/19.
//  Copyright © 2019 Sofia Yobal Castro. All rights reserved.
//

import Foundation

class SuperHeroeResponse: Codable {
    var superheroes : [SuperHeroes]?
}

class SuperHeroes: Codable
{
    var name : String?
    var photo: String?
    var realName : String?
    var height : String?
    var power : String?
    var abilities : String?
    var groups : String?
}
