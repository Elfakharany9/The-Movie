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
import Reachability

class LoginViewController: UIViewController  {

    @IBOutlet weak var TxtFieldUsername: UITextField!
    @IBOutlet weak var TxtFieldPassword: UITextField!
    @IBOutlet weak var BtnLogin: UIButton!
    @IBOutlet weak var Stack: UIStackView!
    
    var Token = ""
    var ActiveConnection = true
    let reachability = Reachability()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TxtFieldPassword.delegate = self
        TxtFieldUsername.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(InternetChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{}
        }
    
    @objc func InternetChanged(note : Notification) {
        let reachability = note.object as! Reachability
        if reachability.connection != .none {
            self.ActiveConnection = true
            GetTokenWithAlamoFire()
            print(ActiveConnection)
        }else{
            self.ActiveConnection = false
              self.showAlert(title: "Connection Error ", message: "Check Connection and Try Again")
            print(ActiveConnection)
        }
    }


    
    func GetTokenWithAlamoFire(){
        let Url = Urls.GetToken
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
    
    func loginwithSessions(username : String , password : String){
        var request = URLRequest(url: URL(string: Urls.loginUrl+Token)!)
        print(request)
        request.httpMethod = "POST"
        let postString = "username=\(username)&password=\(password)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                self.showAlert(title: "Connection Error ", message: "Check Connection and Try Again")
                self.GetTokenWithAlamoFire()
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
     self.showAlert(title: "Login Failed", message: "Username or password Worng")
            }
            
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: Any]
                if let success = try jsonResponse?["success"] {
                    let request_token = jsonResponse?["request_token"]
                    print("RequestTokenAfterSucess\(request_token ?? "NoRequesToken")")
                }
                DispatchQueue.main.async {
                    helper.saveUsername(username: username)
                    helper.UserExsit()
                    self.performSegue(withIdentifier: "ValidLogin", sender: nil)
                }
            }catch _ {
                self.showAlert(title: "Some Thing Got Wrong", message: "Plese Login Again")
                self.GetTokenWithAlamoFire()
            }
        }
        task.resume()
    }//ENDLOGINWITHSESSION
    
    @IBAction func BtnLoginAct(_ sender: Any) {
        if self.ActiveConnection == true {
        let username = self.TxtFieldUsername.text
        let password = self.TxtFieldPassword.text
        if (username != ""  && password !=  ""){
            loginwithSessions(username: username!, password: password!)
        }else{
               self.showAlert(title: "Login Failed", message: "Username or password Worng")
        }
        }else{
              self.showAlert(title: "Connection Error ", message: "Check Connection and Try Again")
        }
    }

}
    extension LoginViewController : UITextFieldDelegate{
        
        // keyboard down
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            
            return true
        }
    }
    

