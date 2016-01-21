//
//  RegistrationFormViewController.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/18/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import UIKit
import Eureka

class RegistrationFormViewController: FormViewController {

    lazy var authManager:AuthenticationManagement = AuthenticationManager()
    
    lazy var preRegUserData = UserPreRegistrationData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRegistrationButton()
        setupForm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRegistrationButton()
    {
        let regButton = UIBarButtonItem(title: "Register", style: .Plain, target: self, action: "registrationButtonAction:")
        regButton.enabled = false
        self.navigationItem.rightBarButtonItem = regButton
    }
    
    func setupForm()
    {
        form
            +++
            Section("Name and LastName")
            
            <<< NameRow(){
                $0.title = "username"
                $0.placeholder = "enter your username"
            }.onChange({ (nameRow) -> () in
                self.preRegUserData.username = nameRow.value ?? ""
                self.checkRegisterButtonEnabled()
            })
            
            +++
            Section("Email")
            
            <<< EmailRow(){
                $0.title = "email"
                $0.placeholder = "enter email"
                }.onChange({ (eRow) -> () in
                self.preRegUserData.email = eRow.value ?? ""
                self.checkRegisterButtonEnabled()
            })
            
            <<< EmailRow(){
                    $0.title = "confirm"
                    $0.placeholder = "enter email"
                }.onChange({ (eRow) -> () in
                    self.preRegUserData.confirmEmail = eRow.value ?? ""
                    self.checkRegisterButtonEnabled()
                })
            
            +++ Section("Password")
            
            <<< PasswordRow(){
                    $0.title = "password"
                    $0.placeholder = "enter pasword"
                }.onChange({ (pRow) -> () in
                    self.preRegUserData.password = pRow.value ?? ""
                    self.checkRegisterButtonEnabled()
                })
            <<< PasswordRow(){
                    $0.title = "confirm"
                    $0.placeholder = "enter pasword"
                }.onChange({ (pRow) -> () in
                    self.preRegUserData.confirmPassword = pRow.value ?? ""
                    self.checkRegisterButtonEnabled()
                })
    
    }
    
    func checkRegisterButtonEnabled()
    {
        self.navigationItem.rightBarButtonItem?.enabled = preRegUserData.userDataSuccessfull
    }
    
    func registrationButtonAction(sender:AnyObject?)
    {
        authManager.delegate = self
        authManager.registerWithParameters(preRegUserData.username, email: preRegUserData.email, password: preRegUserData.password)
    }

    func showMapView()
    {
        self.setRootViewControllerToMainMapView()
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
