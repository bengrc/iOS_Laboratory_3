//
//  MovieViewController.swift
//  laboratory3
//
//  Created by Benjamin on 28/04/2020.
//  Copyright © 2020 Benjamin. All rights reserved.
//

import UIKit

class MoviesViewController: UITableViewController {
    var moviesStore: MoviesStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Film Database"
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView , numberOfRowsInSection section: Int) -> Int {
        return moviesStore.allMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with subtitle appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoSubtitle", for: indexPath)
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let movie : Movie = moviesStore.allMovies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.director + " (rating: " + String(movie.rating) + " )"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let movie = moviesStore.allMovies[indexPath.row]
            let title = "Delete \(movie.title) (directed by \(movie.director))?"
            let message = "Are you sure you want to delete this film?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in // Remove the book from the store
                // remove movie
                self.moviesStore.removeMovie(movie)
                // Also remove that row from the table view with an animation self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView ,moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        moviesStore.moveMovie(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // If the triggered segue is the "showBook" segue
           switch segue.identifier {
               case "showMovieDetails"?:
                   // Figure out which row was just tapped
                   if let row = tableView.indexPathForSelectedRow?.row {
                       // Get the item associated with this row and pass it along
                       let movie = moviesStore.allMovies[row]
                       let movieDetailsViewController = segue.destination as! MovieDetailsViewController
                    print(movie.title)
                    movieDetailsViewController.movie = movie
                   }
               default:
                   preconditionFailure("Unexpected segue identifier.")
           }
       }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func toggleEditingMode(_ sender: UIBarButtonItem) { // If you are currently in editing mode...
        if isEditing {
            // Change text of button to inform user of state sender.setTitle("Edit library", for: .normal)
            // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // Change text of button to inform user of state sender.setTitle("Done", for: .normal)
            // Enter editing mode
            setEditing(true, animated: true)
        }
    }

    @IBAction func addMovie(_ sender: UIBarButtonItem) {
        print("addmovie")
        // Create a new book and add it to the store
        let newMovie = moviesStore.createMovie()
        // Figure out where that item is in the array
        if let index = moviesStore.allMovies.firstIndex(of: newMovie) {
            let indexPath = IndexPath(row: index, section: 0)
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }

}

