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
        let greetingEmailLabel = UILabel()
        greetingEmailLabel.textAlignment = .Center
        greetingEmailLabel.text = email
        greetingEmailLabel.sizeToFit()
        
        greetingEmailLabel.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) )
        
        self.view.addSubview(greetingEmailLabel)
        let timeOut = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(Int64(NSEC_PER_SEC)) * 0.5))
        dispatch_after(timeOut, dispatch_get_main_queue()) {[unowned self] () -> Void in
            
            greetingEmailLabel.removeFromSuperview()
            self.setRootViewControllerToMainMapView()
        }
    }
    
    private func setRootViewControllerToMainMapView()
    {
        guard let mapVC = self.storyboard?.instantiateViewControllerWithIdentifier("MainMapViewController") as? MainMapViewController else
        {
            return
        }
        
        let navHolder = UINavigationController(rootViewController: mapVC)
        
        anAppDelegate()?.window?.rootViewController = navHolder
    }
}
