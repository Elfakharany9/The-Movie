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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
        FetchMoviesWithAlamoFire(Page: 1)
        if MoviesArray.isEmpty{
            tableview.isHidden = true
        }
    }
    
    func FetchMoviesWithAlamoFire(Page : Int){
        let Url =  "http://api.themoviedb.org/3/movie/top_rated?api_key=a619ffd371a3fc63c02faefe0478df7d&page=\(Page)"
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
                } catch  {
                    
                }
            case .failure(_):
                print("Failure")
            }
  }
        
        
    }
    
//
//    func DawnloadImage(ImageUrl : String) -> UIImage {
//        let FullImageUrl = "https://image.tmdb.org/t/p/w185/\(ImageUrl)?api_key=a619ffd371a3fc63c02faefe0478df7d"
//        var DesiredImage = #imageLiteral(resourceName: "star (1)")
//            URLSession.shared.dataTask(with: NSURL(string: FullImageUrl)! as URL, completionHandler: { (data, response, error) -> Void in
//                if error != nil {
//                    print(error)
//                    return
//                }
//                DispatchQueue.main.async(execute: { () -> Void in
//                    let ReturnedImage = UIImage(data: data!)
//                    DesiredImage = ReturnedImage ?? #imageLiteral(resourceName: "clapperboard")
//                    self.tableview.reloadData()
//                 }
//                )
//            }).resume()
//            return DesiredImage
//        }
    
   
    
    }
    

extension TopMovieaViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell
        if MoviesArray.isEmpty{
        }else{
            print(MoviesArray[indexPath.row].title)
        cell?.ConfigurationCell(
            Name: MoviesArray[indexPath.row].title ?? "Title Not Avaliable" ,
            Rate: MoviesArray[indexPath.row].voteAverage ?? 0.0,
            RelaseDate: MoviesArray[indexPath.row].releaseDate ?? "Relase Date Not Avialble")
            let imageURL = MoviesArray[indexPath.row].posterPath
            let ImageFullUrl :URL =  URL(string:  "https://image.tmdb.org/t/p/w185/\(imageURL ?? "")?api_key=a619ffd371a3fc63c02faefe0478df7d")!
          //  let Test = URL(string: "https://image.tmdb.org/t/p/w185//uC6TTUhPpQCmgldGyYveKRAu8JN.jpg?api_key=a619ffd371a3fc63c02faefe0478df7d%22")
            cell?.imgViewMoviePoster.kf.setImage(with: ImageFullUrl)
        }
        return cell!
    }
    
}




