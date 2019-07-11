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
        
        let TextFeildHeight = self.txtFieldMovieName.optimalHeight
        self.txtFieldMovieName.frame =  CGRect(x: txtFieldMovieName.frame.origin.x, y: txtFieldMovieName.frame.origin.y, width: txtFieldMovieName.frame.width, height: TextFeildHeight)
        self.txtFieldMovieName.numberOfLines = 0
        self.lblMovieRelaseDate.text = RelaseDate
        self.txtFieldMovieName.text = Name
        self.LblRate.text = String(Rate)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}

extension UILabel {
    var optimalHeight : CGFloat {
        get
        {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            return label.frame.height
        }
        
    }
}
