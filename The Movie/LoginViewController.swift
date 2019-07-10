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
    
    var Token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetTokenWithAlamoFire()
     //   LoginWithAlamofire()
    }
    
    
    func GetTokenWithAlamoFire(){
        let Url = "https://api.themoviedb.org/3/authentication/token/new?api_key=9f0771d05e64408e58984759f7f759a2"
        Alamofire.request(Url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    // print(response.result.value)
                    let json = JSON(data)
                    let RecivedToken = json["request_token"].stringValue
                    self.Token = RecivedToken
                    print(self.Token)
                }
                break
            case .failure(_):
                print(response.result.error!)
                break
            }
        }
    }//ENDGETTINGTOKEN
    
    func LoginWithAlamofire(){
    
        let headers = ["content-type": "application/json"]
        let parameters : Parameters = [
            "username": "johnny_appleseed",
            "password": "test123",
            "request_token": self.Token
        ]
        
        print(self.Token)
       let LoginUrl = "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=9f0771d05e64408e58984759f7f759a2"
        
        Alamofire.request(LoginUrl, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            print(response)
        }
        
    }//ENDLOGINWITHALAMOFIRE
    
    
    @IBAction func BtnLoginAct(_ sender: Any) {
        LoginWithAlamofire()
    }
    

}
