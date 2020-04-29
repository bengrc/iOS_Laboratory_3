//
//  MovieDetailsViewController.swift
//  laboratory3
//
//  Created by Benjamin on 28/04/2020.
//  Copyright © 2020 Benjamin. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet var movieTitle: UITextField!
    @IBOutlet var movieDirector: UITextField!
    @IBOutlet var movieCreationDate: UITextField!
    @IBOutlet var movieRatingStepper: UIStepper!
    @IBOutlet var movieRating: UITextField!
    @IBOutlet var movieWatchingDate: UIDatePicker!
    @IBOutlet var movieReview: UITextField!
    var movie: Movie!{
        didSet {
            navigationItem.title = movie.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieTitle.text = movie!.title
        movieDirector.text = movie!.director
        movieRating.text = String(movie!.rating)
        movieRatingStepper.value = Double(movie.rating)
        if let watchingDate = movie!.watchingDate {
            movieWatchingDate.date = watchingDate
        }
        movieReview.text = movie!.review
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        movie!.title = movieTitle.text ?? ""
        movie!.director = movieDirector.text ?? ""
        movie!.rating = UInt32(movieRating.text ?? "0") ?? 0
        movie!.review = movieReview.text ?? ""
        if movieWatchingDate.isEnabled {
            movie!.watchingDate = movieWatchingDate.date
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        guard let movie = movie else { return }
        movie.rating = UInt32(sender.value)
        movieRating.text = String(movie.rating)
    }
}
