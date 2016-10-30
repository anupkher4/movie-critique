//
//  ViewController.swift
//  MovieCritique
//
//  Created by Anup Kher on 10/27/16.
//  Copyright © 2016 AK. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchResultsTableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let api = TmdbApi()
    
    let imageConfig = UserDefaults.standard.value(forKey: "movieImageConfig") as? [String : String]
    
    var searchResults: [Movie] = []
    
    @IBAction func searchClicked(_ sender: Any) {
        self.activityIndicator.startAnimating()
        
        DispatchQueue.global().async {
            if let searchString = self.searchTextField.text {
                self.api.searchForMovies(withName: searchString, completionHandler: { [weak self] (allMovies, error) in
                    if error != nil {
                        print(error.debugDescription)
                    }
                    
                    if let movies = allMovies {
                        self?.searchResults = movies.sorted().reversed()
                        
                        DispatchQueue.main.async(execute: {
                            self?.navigationItem.prompt = "Showing search results"
                            self?.activityIndicator.stopAnimating()
                            self?.searchResultsTableView.reloadData()
                        })
                    }
                    
                })
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UserDefaults.standard.removeObject(forKey: "movieImageConfig")
        
        DispatchQueue.global().async {
            self.api.discoverMovies(completionHandler: { [weak self] (popularMovies, error) in
                if error != nil {
                    print(error.debugDescription)
                }
                
                if let movies = popularMovies {
                    self?.searchResults = movies
                    
                    DispatchQueue.main.async(execute: {
                        self?.searchResultsTableView.reloadData()
                    })
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieListToMovieDetail" {
            if let movieDetailViewController = segue.destination as? MovieDetailViewController {
                if let index = searchResultsTableView.indexPathForSelectedRow {
                    let selected = searchResults[index.row]
                    movieDetailViewController.selectedMovieId = selected.id
                    print("Selected movie id: \(selected.id)")
                }
            }
        }
    }

}

extension MovieSearchViewController: UITableViewDelegate {
    
    
}

extension MovieSearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        let movie = searchResults[indexPath.row]
        
        if let date = api.getDateComponents(fromString: movie.release_date) {
            cell.releaseDateLabel.text = "\(date.year)"
        }
        
        cell.titleLabel.text = movie.original_title
        cell.popularityLabel.text = String(format: "%.1f", movie.popularity)
        
        return cell
    }
    
}

