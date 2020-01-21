//
//  MoviesDetailsViewController.swift
//  Movies
//
//  Created by Lucas Santana Brito on 16/01/20.
//  Copyright © 2020 lsb.br. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var detailsMoviesTextView: UITextView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configeDetails()
        setupDetailTextView()
    }
    
    private func setupDetailTextView() {
        detailsMoviesTextView.backgroundColor = .white
        detailsMoviesTextView.textColor = .black
    }
    
    private func configeDetails() {
       if let movie = movie {
           
           title = movie.title
           
           if let backdropPath = movie.backdropPath {
               Util.createActivityIndicator(activityIndicator: activityIndicator, view: movieImageView)
               
               let url = URL(string: "\(urlBaseImageBig)\(backdropPath)")
               movieImageView.sd_setImage(with: url) { (image, error, imageCache, url) in
                   Util.stopActivityIndicator(activityIndicator: self.activityIndicator)
               }
           }
          
           if movie.overview!.isEmpty {
               detailsMoviesTextView.text = "Sem resumo do filme."
           } else {
               detailsMoviesTextView.text = movie.overview
           }
           
           detailsMoviesTextView.isEditable = false
       }
   }
}
