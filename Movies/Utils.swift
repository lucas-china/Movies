//
//  Utils.swift
//  Movies
//
//  Created by Lucas Santana Brito on 16/01/20.
//  Copyright © 2020 lsb.br. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Util {
    
    static func createActivityIndicator(activityIndicator: UIActivityIndicatorView, view: UIView) {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .gray
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    static func stopActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
