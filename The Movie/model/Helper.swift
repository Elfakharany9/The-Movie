//
//  Helper.swift
//  The Movie
//
//  Created by elfakharany on 7/10/19.
//  Copyright © 2019 Mohamed Elfakharany. All rights reserved.
//

import UIKit

class helper: NSObject {
    class func restartApp(){
        guard let window = UIApplication.shared.keyWindow else {return}
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        if IsUserExsit() == true  {
            vc = sb.instantiateViewController(withIdentifier: "Home")
        }else {
            vc = sb.instantiateViewController(withIdentifier: "LoginView")
        }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    class func dleteAPIToken() {
    let def = UserDefaults.standard
    def.removeObject(forKey: "user")
    def.set(false, forKey: "userExsit")
    def.synchronize()

    restartApp()
}

    class func UserExsit() {
        let def = UserDefaults.standard
        def.setValue(true, forKey: "userExsit")
        def.synchronize()
        restartApp()
    }
    
    class func saveUsername(username: String) {
    let def = UserDefaults.standard
    def.setValue(username, forKey: "user")
    def.synchronize()
    restartApp()
}
    
    class func loadUsername()-> String {
        let def = UserDefaults.standard
        let user = def.object(forKey: "user") as? String
        def.synchronize()
        return user ?? ""
    }

    class  func IsUserExsit() -> (Bool?) {
    let def = UserDefaults.standard
    return (def.object(forKey: "userExsit") as? Bool)
}
    
    
}
