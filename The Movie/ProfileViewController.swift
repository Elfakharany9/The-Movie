//
//  ProfileViewController.swift
//  The Movie
//
//  Created by elfakharany on 7/10/19.
//  Copyright © 2019 Mohamed Elfakharany. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var UserName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.UserName.text =  helper.loadUsername()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func LogutPressed(_ sender: Any) {
        helper.dleteAPIToken()
        helper.restartApp()
    }
}
