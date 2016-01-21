//
//  RegistrationFormViewController+AuthenticationManagerDelegate.swift
//  vip330
//
//  Created by Ivan Yavorin on 1/21/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import Foundation

extension RegistrationFormViewController : AuthenticationManagerDelegate {
    
    func authenticationProcessDidStart() {
        setLoadingIndicatorVisible(true)
    }
    
    func registrationProcessDidFinishWithResult(userId: String?, error: NetworkingError?) {
        dispatchAsyncMain(){[weak self] in
            self?.setLoadingIndicatorVisible(false)
            self?.showMapView()
        }
    }
}