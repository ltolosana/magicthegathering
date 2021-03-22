//
//  CardDetailWireframe.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 22/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit

class CardDetailWireframe: BaseWireframe, CardDetailWireframeContract {
    weak var output: CardDetailWireframeOutputContract!
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
