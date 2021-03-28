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
        /*
         if let magicFont = UIFont(name: Constants.magicFont, size: 24) {
         let attributes = [NSAttributedString.Key.font: magicFont, NSAttributedString.Key.foregroundColor: color]
         self.navigationController?.navigationBar.titleTextAttributes = attributes
         */
        
        // En vez de usar el codigo de arriba que solo cambia la fuente del Title del navigation,
        // he usado lo de abajo, que cambia los atributos de la navigation bar, aunque aparece
        // un problema que explico un poco mas abajo
        
        let navBarAppearance = UINavigationBarAppearance()
        if let magicFont = UIFont(name: Constants.magicFont, size: 24) {
            let attributes = [NSAttributedString.Key.font: magicFont, NSAttributedString.Key.foregroundColor: color]
            navBarAppearance.titleTextAttributes = attributes
            // Al poner esta propiedad de aqui abajo, para cambiar la fuente del texto del boton de "Atras"
            // aparecen mensajes en consola que creo que son de CoreUI Catalog
            // No he sabido averiguar por que aparecen ni como quitarlos
            // Bueno, como quitarlos, si, no aplicando la fuente
            navBarAppearance.backButtonAppearance.normal.titleTextAttributes = attributes
            
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.tintColor = color
        }
    }
    
    func setUpTabBarItemFont(fontSize: CGFloat, color: UIColor) {
        if let magicFont = UIFont(name: Constants.magicFont, size: fontSize) {
            let attributes = [NSAttributedString.Key.font: magicFont, NSAttributedString.Key.foregroundColor: color]
            self.tabBarItem?.setTitleTextAttributes(attributes, for: .normal)
        }
    }
}
