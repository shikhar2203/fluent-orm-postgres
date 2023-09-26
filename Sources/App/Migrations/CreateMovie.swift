import Fluent
import FluentPostgresDriver

struct CreateMovie: Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("movies") // table name
            .id()
            .field("title", .string) // column name
            .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("movies").delete() // drop the table
    }
    
     
//    func prepare(on database: Database) async throws {
//        try await database.schema("todos")
//            .id()
//            .field("title", .string, .required)
//            .create()
//    }
//
//    func revert(on database: Database) async throws {
//        try await database.schema("todos").delete()
//    }
}
