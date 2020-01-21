//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Lucas Santana Brito on 16/01/20.
//  Copyright © 2020 lsb.br. All rights reserved.
//

import UIKit
import SDWebImage
class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var folderView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func updateUI(movie: Movie) {
        nameMovieLabel.text = movie.title
        
        if let posterPath = movie.posterPath {
            Util.createActivityIndicator(activityIndicator: activityIndicator, view: movieImageView)
            
            let url = URL(string: "\(urlBaseImage)\(posterPath)")
            movieImageView.sd_setImage(with: url) { (image, error, imageCache, url) in
                DispatchQueue.main.async {
                    Util.stopActivityIndicator(activityIndicator: self.activityIndicator)
                }
            }
        }
        
        setupFolderView()
    }
    
    private func setupFolderView() {
        folderView.layer.backgroundColor = UIColor.white.cgColor
        folderView.layer.shadowColor = UIColor.white.cgColor
        folderView.layer.shadowOpacity = 0.2
        folderView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        folderView.layer.shadowRadius = 4.0
    }
}
