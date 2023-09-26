import Fluent
import Vapor

//final class Todo: Model, Content {
//    static let schema = "todos"
//    
//    @ID(key: .id)
//    var id: UUID?
//
//    @Field(key: "title")
//    var title: String
//
//    init() { }
//
//    init(id: UUID? = nil, title: String) {
//        self.id = id
//        self.title = title
//    }
//}

final class Movie: Model, Content {
    
    static let schema = "movies"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    init(){
        
    }
    
    init(id: UUID? = nil, title: String){
        self.id = id
        self.title = title
    }
}
