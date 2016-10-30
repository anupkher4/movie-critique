//
//  MovieDetailViewController.swift
//  MovieCritique
//
//  Created by Anup Kher on 10/28/16.
//  Copyright © 2016 AK. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var popularityLabel: UILabel!
    @IBOutlet var userRatingLabel: UILabel!
    @IBOutlet var internetRatingLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let api = TmdbApi()
    
    var selectedMovieId: Int?
    
    var selectedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.activityIndicator.startAnimating()
        
        // Update movie details
        DispatchQueue.global().async {
            if let id = self.selectedMovieId {
                
                self.api.getMovie(forId: id, completionHandler: { [weak self] (movie, error) in
                    
                    if error != nil {
                        print(error.debugDescription)
                    }
                    
                    if let movie = movie {
                        self?.selectedMovie = movie
                        
                        // Download movie poster
                        if let posterConfig = UserDefaults.standard.object(forKey: "movieImageConfig") as? [String : String] {
                            if let baseUrl = posterConfig["url"], let posterSize = posterConfig["posterSize"], let path = movie.poster_path {
                                let posterPath = "\(baseUrl)\(posterSize)\(path)"
                                
                                if let url = URL(string: posterPath) {
                                    if let data = NSData(contentsOf: url) {
                                        if let image = UIImage(data: data as Data) {
                                            DispatchQueue.main.async(execute: {
                                                self?.posterImageView.image = image
                                            })
                                        }
                                    }
                                }
                            }
                        }
                        
                        DispatchQueue.main.async(execute: {
                            self?.navigationItem.title = movie.original_title
                            self?.titleLabel.text = movie.original_title
                            if let date = self?.api.getDateComponents(fromString: movie.release_date) {
                                self?.yearLabel.text = "(\(date.year))"
                            }
                            self?.popularityLabel.text = "TMDB Popularity: \(String(format: "%.1f", movie.popularity))"
                            self?.userRatingLabel.text = "TMDB User Rating: \(String(format: "%.1f", movie.vote_average))/10"
                            
                            self?.activityIndicator.stopAnimating()
                        })
                        
                        // Get Imdb rating
                        if let imdbId = movie.imdb_id {
                            
                            self?.api.findExternalMovieDetails(withId: imdbId, completionHandler: { (movie, error) in
                                if error != nil {
                                    print(error.debugDescription)
                                }
                                
                                if let extMovie = movie {
                                    DispatchQueue.main.async(execute: {
                                        self?.internetRatingLabel.text = "IMDB User Rating: \(extMovie.vote_average)/10"
                                    })
                                }
                            })
                        }
                    }
                })
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
