//
//  File.swift
//  
//
//  Created by shikhar on 29/09/23.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct AddPosterColumnToMovies: Migration {
    
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("movies")
            .field("poster", .string)
            .update()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("movies")
            .deleteField("poster")
            .delete()
    }
    
    
}
