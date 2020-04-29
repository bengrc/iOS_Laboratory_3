//
//  MovieViewController.swift
//  laboratory3
//
//  Created by Benjamin on 24/04/2020.
//  Copyright © 2020 Benjamin. All rights reserved.
//

import UIKit

class MoviesViewController: UITableViewController {
    var moviesStore: MoviesStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Film Database"
    }

    override func tableView(_ tableView: UITableView , numberOfRowsInSection section: Int) -> Int {
        return moviesStore.allMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoSubtitle", for: indexPath)
        let movie : Movie = moviesStore.allMovies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.director + " (rating: " + String(movie.rating) + " )"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = moviesStore.allMovies[indexPath.row]
            let title = "Delete \(movie.title) (directed by \(movie.director))?"
            let message = "Are you sure you want to delete this film?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                self.moviesStore.removeMovie(movie)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView ,moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moviesStore.moveMovie(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "showMovieDetails"?:
                if let row = tableView.indexPathForSelectedRow?.row {
                    let movie = moviesStore.allMovies[row]
                    let movieDetailsViewController = segue.destination as! MovieDetailsViewController
                    movieDetailsViewController.movie = movie
                }
            case "newMovie"?:
                let movie = Movie()
                movie.title = "Title"
                movie.director = "Director"
                movie.rating = 5;
                let movieDetailsViewController = segue.destination as! MovieDetailsViewController
                movieDetailsViewController.movie = movie
            default:
                preconditionFailure("Unexpected segue identifier.")
        }
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func toggleEditingMode(_ sender: UIBarButtonItem) {
        if isEditing {
            setEditing(false, animated: true)
        } else {
            setEditing(true, animated: true)
        }
    }

    @IBAction func addMovie(_ sender: UIBarButtonItem) {
        let newMovie = moviesStore.createMovie()
        if let index = moviesStore.allMovies.firstIndex(of: newMovie) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func movieViewDone(segue:UIStoryboardSegue) {
        let movieDetailsView = (segue.source as! MovieDetailsViewController)
        movieDetailsView.saveMovieFields()
        let newMovie = movieDetailsView.movie
        if !moviesStore.allMovies.contains(newMovie!) {
            moviesStore.allMovies.append(newMovie!)
            tableView.reloadData()
        }
    }
    
    @IBAction func movieViewCancel(segue:UIStoryboardSegue) {}
}

