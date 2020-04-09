//
//  ViewController.swift
//  CanvasShortcuts
//
//  
//  Copyright © 2020 Cory Swainston. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logIn(_ sender: Any) {
        if let link = URL(string: "http://10.0.0.192/login/oauth2/auth?client_id=10000000000001&response_type=code&redirect_uri=canvasshortcuts://auth") {
            UIApplication.shared.open(link)
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        setAccessToken(token: "")
    }
}

