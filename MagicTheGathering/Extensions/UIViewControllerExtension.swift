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
    
    func setUpNavigationTitleFont(fontSize: CGFloat, color: UIColor) {
        if let magicFont = UIFont(name: Constants.magicFont, size: 24) {
            let attributes = [NSAttributedString.Key.font: magicFont, NSAttributedString.Key.foregroundColor: color]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
  
        // El siguiente codigo es para cambiar, ademas del title, el boton de atras
        // de una forma que se usa a partir de iOS 13
        // El problema es que en la fuente que he escogido no aparee el simbolo "<"
        // por lo que saca un monton de mensajes en la consola, asi que,
        // aunque quede un poco mas feo, voy a dejar el tipo de letra por defecto
        // para el boton de back del navigation
/*
        let navBarAppearance = UINavigationBarAppearance()
        if let magicFont = UIFont(name: Constants.magicFont, size: 24) {
            let attributes = [NSAttributedString.Key.font: magicFont]
            navBarAppearance.titleTextAttributes = attributes
            navBarAppearance.backButtonAppearance.normal.titleTextAttributes = attributes
            
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
 */
        }
    }
    
    func setUpTabBarItemFont(fontSize: CGFloat, color: UIColor) {
        if let magicFont = UIFont(name: Constants.magicFont, size: fontSize) {
            let attributes = [NSAttributedString.Key.font: magicFont, NSAttributedString.Key.foregroundColor: color]
            self.tabBarItem?.setTitleTextAttributes(attributes, for: .normal)
        }
    }
}
