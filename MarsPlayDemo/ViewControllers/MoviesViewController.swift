//
//  UsersViewController.swift
//  MarsPlayDemo
//
//  Created by Pawan Joshi on 11/12/18.
//  Copyright © 2018 Pawan Joshi. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet var moviesCollectionView: UICollectionView!
    
    //Public iVars
    
    //Private iVars
    fileprivate var movies: [Movie] = [Movie]()
    fileprivate var refreshControl: UIRefreshControl = UIRefreshControl()
    fileprivate var nextMoviesPage: Int = 1
    fileprivate let moviesFetchThreshold: Int = 3
    
    //Public Computed iVars
    
    //Private Computed iVars
    
}

// MARK: - View Life Cycle
extension MoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        getMovies()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - Custom Tagret-Actions
extension MoviesViewController {
    @objc fileprivate func getMovies(_ isLoadingMore: Bool = false) {
        if !isLoadingMore {
            movies.removeAll()
            moviesCollectionView.reloadData()
            AppUtilities.showLoader()
            nextMoviesPage = 1
        }
        DataManager.getMovies(nextMoviesPage) { [weak self] (success, message, movieList, nextPage) in
            AppUtilities.hideLoader()
            guard self != nil else {
                return
            }
            self?.refreshControl.endRefreshing()
            if success {
                self?.movies.append(contentsOf: movieList)
                self?.nextMoviesPage = nextPage
            }
            self?.moviesCollectionView.reloadData()
        }
    }
}

// MARK: - Private Functions
extension MoviesViewController {
    
    fileprivate func setupUI() {
        setupCollectionViews()
    }
    
    fileprivate func setupCollectionViews() {
        let nib = UINib(nibName: MovieCell.xibName, bundle: nil)
        moviesCollectionView.register(nib, forCellWithReuseIdentifier: MovieCell.cellIdentifier)
    }
    
    fileprivate func setupNavigationBar() {
        title = "Movies"
    }
}

// MARK: - IBActions
extension MoviesViewController {
    
}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.cellIdentifier, for: indexPath) as? MovieCell {
            let movie = movies[indexPath.row]
            cell.parentViewController = self
            cell.configure(movie: movie)
            return cell
        } else {
            return MovieCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 187, height: 217)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (movies.count - indexPath.row) == moviesFetchThreshold && nextMoviesPage > 0 {
            getMovies(true)
        }
    }
    
}

