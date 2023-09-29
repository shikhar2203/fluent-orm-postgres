//
//  File.swift
//  
//
//  Created by shikhar on 29/09/23.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateActor: Migration {
    
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        
        database.schema("actors")
            .id()
            .field("name", .string)
            .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("actors").delete()
    }
    
    
}
