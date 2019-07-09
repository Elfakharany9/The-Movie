//
//  LoginViewController.swift
//  The Movie
//
//  Created by elfakharany on 7/9/19.
//  Copyright © 2019 Mohamed Elfakharany. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var TxtFieldUsername: UITextField!
    @IBOutlet weak var TxtFieldPassword: UITextField!
    
    @IBOutlet weak var BtnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func LoginWithAlamofire (username:String , password:String){
        
        let url = "https://api.us.onelogin.com/auth/oauth2/token"
        
        let parameters: [String: String] = [
            "grant_type" :  "client_credentials"
        ]
        
        let header : [String: String] = [
            "Content-Type" : "application/json",
            "Authorization" : "client_id"
        ]
        
    }///ENDLOGINFUNC
    
    @IBAction func BtnLoginAct(_ sender: Any) {
    }
    

}
