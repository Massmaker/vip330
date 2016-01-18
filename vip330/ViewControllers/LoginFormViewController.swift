//
//  ViewController.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import UIKit
import Eureka

class LoginFormViewController: FormViewController {

    var userEmail:String?
    
    var userPassword:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupTableView()
    {
        form +++ Section() <<< EmailRow(){
            $0.title = "email"
            $0.value = userEmail
        }.onChange({ (eRow) -> () in
            self.userEmail = eRow.value
            self.checkLoginButtonEnabled()
        })
            <<< PasswordRow(){
                $0.title = "password"
                $0.value = userPassword
        }.onChange({ (pRow) -> () in
            self.userPassword = pRow.value
            self.checkLoginButtonEnabled()
        })
    }
    
    func startLoginButtonAction(sender:AnyObject)
    {
        self.startLogin()
    }
    
    private func startLogin()
    {
        
    }
    
    private func checkLoginButtonEnabled()
    {
        guard
            let email = self.userEmail where !email.characters.isEmpty,
            let password = self.userPassword where !password.characters.isEmpty
            else
        {
            self.navigationItem.rightBarButtonItem = nil
            return
        }
        
        guard let _ = self.navigationItem.rightBarButtonItem else
        {
             self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login", style: .Plain, target: self, action: "startLoginButtonAction:")
            return
        }
    }
}

