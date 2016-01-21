//
//  DiscountImageViewController.swift
//  vip330
//
//  Created by CloudCraft on 1/21/16.
//  Copyright © 2016 Massmaker. All rights reserved.
//

import UIKit

class DiscountImageViewController: UIViewController {

    @IBOutlet weak var imageView:UIImageView!
    
    lazy var networkRequester:NetworkApiCaller = NetworkApiCaller()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard imageView.image == nil else
        {
            return
        }
        
        if let anId = anAppDelegate()?.currentUserID where anId.characters.count > 0
        {
            dispatchAsyncBackground(){
                    
            }
            let imageReader = DefaultsManager()
            if let anImage = imageReader.getDiscountImageFromDocumentsForUserId(anId)
            {
                dispatchAsyncMain(){[weak self] in
                     self?.imageView.image = anImage
                }
            }
            else
            {
                dispatchAsyncMain(){[weak self] in
                    self?.setLoadingIndicatorVisible(true)
                }
                
                networkRequester.performDiscountCardRequest(anId) { (response) -> () in
                    
                    dispatchAsyncMain(){[weak self] in
                        
                        self?.setLoadingIndicatorVisible(false)
                        
                        switch response
                        {
                            case .Failure(let customError):
                                
                                switch customError
                                {
                                    case .Unknown(let message):
                                        print("Image Downloading image error: \(message)")
                                        self?.showAlertWithTitle("Error", message: "Could not load Your discount card image. Please try later.", cancelButtonTitle: "Ok")
                                    case .Failure(let code, let optionalMessage):
                                        self?.showAlertWithTitle("Error", message: "code: \(code), reason: \(optionalMessage)", cancelButtonTitle: "Ok")
                                }
                            case .Success(let responseObject):
                                if let anImage = responseObject as? UIImage
                                {
                                    self?.imageView.image = anImage
                                    
                                    dispatchAsyncBackground(){
                                        DefaultsManager().saveDiscountImageToDocuments(anImage, forUserId: anId)
                                    }
                                }
                        }
                    }
                }//performDiscountCardRequest
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        setLoadingIndicatorVisible(false)
    }
    

}
