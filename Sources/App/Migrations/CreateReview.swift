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

struct CreateReview: Migration {
    
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("reviews")
            .id()
            .field("title", .string)
            .field("body", .string)
            .field("movie_id", .uuid, .references("movies", "id"))
            .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("reviews").delete()
    }
    
    
}
