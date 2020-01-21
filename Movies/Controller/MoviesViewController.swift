//
//  MoviesViewController.swift
//  Movies
//
//  Created by Lucas Santana Brito on 16/01/20.
//  Copyright © 2020 lsb.br. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var moviesArray = [Movie]()
    var page = 1
    var totalPages = 0
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAplication()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        moviesCollectionView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
    }
    
    func initAplication() {
        if Util.isConnectedToInternet() {
            downloadMovies()
        } else {
            let mensagem = "Para usar o aplicativo, conecte com a internet."
            let alert = UIAlertController(title: "Ops!", message: mensagem, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                action in
                self.initAplication()
            }))
            self.present(alert, animated: true)
        }
    }
    
    func downloadMovies() {
        isLoading = true
        Movie.downloadMovies(page: page) { [weak self] (isSucess, movies, totalPages) in
            guard let this = self else { return }
            if isSucess {
                this.moviesArray += movies
                this.totalPages = totalPages
                print(this.moviesArray.last?.title)
                DispatchQueue.main.async {
                    this.isLoading = false
                    this.moviesCollectionView.reloadData()
                }
            }
        }
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath)
        
        if let cellMovie = cell as? MovieCollectionViewCell {
            cellMovie.updateUI(movie: moviesArray[indexPath.row])
            return cellMovie
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "moviesDetailsVC")
        
        if let movieDetailsVC = viewController as? MovieDetailsViewController {
            movieDetailsVC.movie = moviesArray[indexPath.row]
            navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading && page < totalPages {
            page += 1
            downloadMovies()
        }
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width/2.18
        let height = view.frame.height/2.35
        
        let size = CGSize(width: width, height: height)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10.0,
                            left: 10.0,
                            bottom: 10.0,
                            right: 10.0)
    }
}
