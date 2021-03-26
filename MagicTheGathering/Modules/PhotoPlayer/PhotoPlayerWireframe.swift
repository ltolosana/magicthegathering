//
//  PhotoPlayerWireframe.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 26/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit

class PhotoPlayerWireframe: BaseWireframe, PhotoPlayerWireframeContract {
    weak var output: PhotoPlayerWireframeOutputContract!
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
