//
//  UIViewControllerExtension.swift
//  VIPER
//
//  Created by Manuel Alfonso Terol on 04/11/2020.
//
import UIKit

extension UIViewController {
    
    /// Get top View Controller
    ///
    /// - Returns: top view controller if exist
    static func topViewController() -> UIViewController? {
        
        if var topController = UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        
        return nil
    }
    
    func setUpNavigationTitle(title: String) {
        if let magicFontTitle = UIFont(name: "MagicMedieval", size: 24) {
            let attributes = [NSAttributedString.Key.font: magicFontTitle]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
        }
        
        self.title = title
    }
    
}
