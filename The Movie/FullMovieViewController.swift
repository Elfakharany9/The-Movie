//
//  FullMovieViewController.swift
//  The Movie
//
//  Created by elfakharany on 7/10/19.
//  Copyright © 2019 Mohamed Elfakharany. All rights reserved.
//

import UIKit

class FullMovieViewController: UIViewController {

    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var LblMovieTtle: UILabel!
    @IBOutlet weak var LblRelaseDate: UILabel!
    @IBOutlet weak var LblLanguege: UILabel!
    @IBOutlet weak var LblRate: UILabel!
    @IBOutlet weak var LblOverview: UITextView!
    
    var CurrentMovie : Movie? = nil
    var CurrentMoviePoster : UIImage? = nil
    
    func showAlertAction(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CurrentMovie != nil && CurrentMoviePoster != nil{
        ConfigureView(SelectedMovie: CurrentMovie!, MoviePoster: CurrentMoviePoster!)
        }else{
           self.showAlertAction(title: "Oops", message: "Something Got Wrong")
        }
    }

    func ConfigureView( SelectedMovie : Movie , MoviePoster : UIImage ){
        self.imageViewPoster.image = MoviePoster
        self.LblMovieTtle.text = SelectedMovie.title
        self.LblRate.text = "\(SelectedMovie.voteAverage ?? 0.0)"
        self.LblLanguege.text = SelectedMovie.originalLanguage
        self.LblOverview.text = SelectedMovie.overview
        self.LblRelaseDate.text = SelectedMovie.releaseDate
                print("Here\(CurrentMovie?.overview)")
    }
    
}
