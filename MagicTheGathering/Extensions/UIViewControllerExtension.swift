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
        if let magicFontTitle = UIFont(name: Constants.magicFont, size: 24) {
            let attributes = [NSAttributedString.Key.font: magicFontTitle]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
        }
        
        self.title = title
    }
    
    func setUpTabBarItemFont(fontSize: CGFloat, color: UIColor ) {
        if let magicFontTitle = UIFont(name: Constants.magicFont, size: fontSize) {
            let attributes = [NSAttributedString.Key.font: magicFontTitle, NSAttributedString.Key.foregroundColor: color]
            self.tabBarItem?.setTitleTextAttributes(attributes, for: .normal)
        }
    }
}
