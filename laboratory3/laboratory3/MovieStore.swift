//
//  MovieStore.swift
//  laboratory3
//
//  Created by Benjamin on 24/04/2020.
//  Copyright © 2020 Benjamin. All rights reserved.
//

import UIKit

class MoviesStore {
    var allMovies = [Movie]()
 
    @discardableResult func createMovie() -> Movie {
        let newMovie = Movie(random: true)
        allMovies.append(newMovie)
        return newMovie
    }
    
    func removeMovie(_ movie: Movie) {
        if let index = allMovies.firstIndex(of: movie) {
            allMovies.remove(at: index)
        }
    }
    
    func moveMovie(from fromIndex: Int, to toIndex: Int) {
        if (fromIndex == toIndex) {
            return;
        }
        let movedMovie = allMovies[fromIndex]
        allMovies.remove(at: fromIndex)
        allMovies.insert(movedMovie, at: toIndex)
    }
}
