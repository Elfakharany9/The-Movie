//
//  TopMovieaViewController.swift
//  The Movie
//
//  Created by elfakharany on 7/9/19.
//  Copyright © 2019 Mohamed Elfakharany. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class TopMovieaViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var MoviesArray = [Movie]()
    var CurrentPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
        FetchMoviesWithAlamoFire(Page: 1)
        if MoviesArray.isEmpty{
            tableview.isHidden = true
        }
    }
    
    
    func showAlertAction(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToFullMovie" {
            let NextView = segue.destination as! FullMovieViewController
            let indexForSelectedCell = tableview.indexPathForSelectedRow
            let SelectedCell = tableview.cellForRow(at: indexForSelectedCell!) as? MovieTableViewCell
            NextView.CurrentMoviePoster = SelectedCell?.imgViewMoviePoster.image
            NextView.CurrentMovie = MoviesArray[(indexForSelectedCell?.row)!]
        }
    }
    
    func FetchMoviesWithAlamoFire(Page : Int){
        let Url =  "http://api.themoviedb.org/3/movie/top_rated?api_key=a619ffd371a3fc63c02faefe0478df7d&page=\(Page)"
        print("TheRequest\(Url)")
        Alamofire.request(Url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { response in
            switch response.result
            {
            case .success(let value):
                let json = JSON(value).dictionary
                do {
                    let datas = try json!["results"]?.rawData()
                    do {
                        let RecivedMovies = try? JSONDecoder().decode([Movie].self, from: datas!)
                        for NextMovie in RecivedMovies! {
                            if NextMovie.title != self.MoviesArray.last?.title{
                                self.MoviesArray.append(NextMovie)
                            }
                        }
                        self.tableview.isHidden = false
                        self.tableview.reloadData()
                    }
                } catch {}
            case .failure(_):
                self.showAlertAction(title: "Some thing Got Wrong ..", message: "Check Your Connection")
            }
        }
    }
}


extension TopMovieaViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell
        if MoviesArray.isEmpty{
        }else{
        cell?.ConfigurationCell(
            Name: MoviesArray[indexPath.row].title ?? "Title Not Avaliable" ,
            Rate: MoviesArray[indexPath.row].voteAverage ?? 0.0,
            RelaseDate: MoviesArray[indexPath.row].releaseDate ?? "Relase Date Not Avialble")
            let imageURL = MoviesArray[indexPath.row].posterPath
            let ImageFullUrl :URL =  URL(string:  "https://image.tmdb.org/t/p/w185/\(imageURL ?? "")?api_key=a619ffd371a3fc63c02faefe0478df7d")!
            cell?.imgViewMoviePoster.kf.setImage(with: ImageFullUrl)
        }
        
 
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == MoviesArray.count - 1 {
            FetchMoviesWithAlamoFire(Page: CurrentPage + 1)
            CurrentPage += 1
            tableView.reloadData()
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToFullMovie", sender: nil)
    }
    
}




