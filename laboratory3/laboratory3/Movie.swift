//
//  Movie.swift
//  laboratory3
//
//  Created by Benjamin on 28/04/2020.
//  Copyright © 2020 Benjamin. All rights reserved.
//

import UIKit

class Movie: NSObject {
    var title: String
    var director:String
    var rating: UInt32
    var watchingDate: Date?
    var review: String
    var dateCreated: Date;
    
    init(title: String, director: String, rating: UInt32, watchingDate: Date?, review: String, dateCreated: Date) {
        self.title = title
        self.director = director
        self.rating = rating
        self.watchingDate = watchingDate
        self.review = review
        self.dateCreated = Date()
        super.init()
    }
    

    convenience init(random: Bool = false) {
        let dateCreated = Date()
        if (random) {
            let movies = ["Matrix", "Blade Runner", "Ready Player One", "Star Wars"]
            let directors = ["‎Les Wachowski", "Ridley Scott", "Steven Spielberg", "George Lucas"]
            var idx = arc4random_uniform(UInt32(movies.count))
            let randomMovies = movies[Int(idx)]
            idx = arc4random_uniform(UInt32(directors.count))
            let randomDirectors = directors[Int(idx)]
            let randomRating = arc4random_uniform(UInt32(10))
            
            self.init(title: randomMovies, director: randomDirectors, rating: randomRating, watchingDate: nil, review: "", dateCreated: dateCreated)
        } else {
            self.init(title: "", director: "", rating: 0, watchingDate: nil, review: "", dateCreated: dateCreated)
        }
    }
}
