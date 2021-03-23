//
//  MainTabBarWireframe.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit

class MainTabBarWireframe: BaseWireframe, MainTabBarWireframeContract {
    weak var output: MainTabBarWireframeOutputContract!
    weak var view: UIViewController!

    /// Show basic loading
    /// - Parameters:
    ///   - text: text
    func showBasicLoading(text: String) {
    }
    
    /// Hide basic loading
    func hideBasicLoading(completion: @escaping (() -> Void)) {
    }
    
}
