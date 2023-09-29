import Fluent
import Vapor

func routes(_ app: Application) throws {

    // /movie/movieId/actor/actorId
    app.post("movie", ":movieId", "actor", ":actorId") { req -> EventLoopFuture<HTTPStatus> in
        
        let movie = Movie.find(req.parameters.get("movieId"), on: req.db)
            .unwrap(or: Abort(.notFound))
        
        let actor = Actor.find(req.parameters.get("actorId"), on: req.db)
            .unwrap(or: Abort(.notFound))

        return movie.and(actor).flatMap { (movie, actor) in
            movie.$actors.attach(actor, on: req.db)
        }.transform(to: .ok)
    }
    
    // /actors
    
    app.get("actors"){ req in
        
        Actor.query(on: req.db).with(\.$movies).all()
    }
    
    app.post("actors") { req -> EventLoopFuture<Actor> in
        
        let actor = try req.content.decode(Actor.self)
        return actor.create(on: req.db).map { actor }
    }
    
    // /movies
    app.get("movies"){ req in
        Movie.query(on: req.db).with(\.$actors).with(\.$reviews).all()
    }
    
    // /movies/id
    app.get("movies",":movieId") { req -> EventLoopFuture<Movie> in
        
        Movie.find(req.parameters.get("movieId"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    // /movies PUT
    app.put("movies") { req -> EventLoopFuture<HTTPStatus> in
        
        let movie = try req.content.decode(Movie.self)
        
        return Movie.find(movie.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.title = movie.title
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    // /movies/id DELETE
    app.delete("movies",":movieId") { req -> EventLoopFuture<HTTPStatus> in
        
        Movie.find(req.parameters.get("movieId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: req.db)
            }.transform(to: .ok)
        
    }
    
    // /movies POST
    app.post("movies") { req -> EventLoopFuture<Movie> in
        
        let movie = try req.content.decode(Movie.self)
        return movie.create(on: req.db).map { movie }
    }
    
    // /reviews
    app.post("reviews") { req -> EventLoopFuture<Review> in
        
        let review = try req.content.decode(Review.self)
        return review.create(on: req.db).map { review }
    }
}
