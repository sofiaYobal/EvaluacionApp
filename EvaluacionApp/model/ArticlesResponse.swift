//
//  ArticlesResponse.swift
//  EvaluacionApp
//
//  Created by Sofia Yobal Castro on 10/2/19.
//  Copyright © 2019 Sofia Yobal Castro. All rights reserved.
//

import Foundation

class ArticlesResponse: Codable{
    var status : String?
    var totalResults : Int?
    var articles : [Article]?
}

class Article: Codable {
    var source: Source?
    var author : String?
    var title : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String?
    var content: String?
}

class Source : Codable {
    // var id   : Int?
    var name : String?
}
