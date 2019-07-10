//
//  MovieTableViewCell.swift
//  The Movie
//
//  Created by elfakharany on 7/9/19.
//  Copyright © 2019 Mohamed Elfakharany. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imgViewMoviePoster: UIImageView!
    @IBOutlet weak var txtFieldMovieName: UILabel!
    @IBOutlet weak var LblRate: UILabel!
    @IBOutlet weak var lblMovieRelaseDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func ConfigurationCell(Name: String , Rate : Double , RelaseDate : String ){
        self.lblMovieRelaseDate.text = RelaseDate
        self.txtFieldMovieName.text = Name
        self.LblRate.text = String(Rate)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
