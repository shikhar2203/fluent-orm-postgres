//
//  File.swift
//  
//
//  Created by shikhar on 29/09/23.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class Review: Model, Content {
    
    static let schema = "reviews"
    
    @ID(key: .id) // PK
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "body")
    var body: String
    
    // belongsTo - Review belongs to a movie
    @Parent(key: "movie_id") // FK
    var movie: Movie
    
    init() {  }
    
    init(id: UUID? = nil, title: String, body: String) {
        self.id = id
        self.title = title
        self.body = body
    }
    
}
