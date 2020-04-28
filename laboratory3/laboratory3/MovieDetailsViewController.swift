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
    @IBOutlet var movieRating: UITextField!
    @IBOutlet var movieWatchingDate: UIDatePicker!
    @IBOutlet var movieReview: UITextField!
    var movie: Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieTitle.text = movie!.title
        movieDirector.text = movie!.director
        movieRating.text = String(movie!.rating)
        //movieRatingStepper.value = Double(movie?.rating)
        if let watchingDate = movie!.watchingDate {
            movieWatchingDate.date = watchingDate
        }
        movieReview.text = movie!.review
    }
}
