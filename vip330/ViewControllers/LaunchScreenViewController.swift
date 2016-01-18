//
//  LaunchScreenViewController.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    lazy var authManager = AuthenticationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.authManager.delegate = self
        self.authManager.startCredentialsChecking()
    }
    
    func showLoginScreen(credentialsResult:CredentialsCheckResult)
    {
        guard let loginNavHolder = self.storyboard?.instantiateViewControllerWithIdentifier("LoginNavigationController") as? UINavigationController else
        {
            //some bad error
            return
        }
        
        var lvEmail = ""
        
        switch credentialsResult
        {
            case .EmailOnly(let email):
                lvEmail = email
            default:
                break
        }
        
        let viewControllers = loginNavHolder.viewControllers
        if let loginVC = viewControllers.first as? LoginFormViewController
        {
            loginVC.userEmail = lvEmail
        }
        
        UIApplication.sharedApplication().delegate?.window??.rootViewController = loginNavHolder
    }
    
    func showMapViewScreen(email:String)
    {
        
    }
}
