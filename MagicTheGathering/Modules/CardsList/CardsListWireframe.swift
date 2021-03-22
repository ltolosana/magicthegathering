//
//  CardsListWireframe.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 21/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit

class CardsListWireframe: BaseWireframe, CardsListWireframeContract {
    weak var output: CardsListWireframeOutputContract!
    weak var view: UIViewController!

//    weak var loadingDelegate: LoadingViewDelegate!
    
    /// Show basic loading
    /// - Parameters:
    ///   - text: text
    func showBasicLoading(text: String) {
//        let loadingVC = LoadingViewController()
//        self.loadingDelegate = loadingVC
//        
//        self.presentView(from: self.view, useCase: loadingVC, withTransition: .modal,
//                         modalPresentationStyle: .overCurrentContext, animated: false, completion: {
//            loadingVC.updateTitle(with: text)
//        })
    }
    
    /// Hide basic loading
    func hideBasicLoading(completion: @escaping (() -> Void)) {
//        self.loadingDelegate?.dismiss {
//            completion()
//        }
    }
    
    func feedbackError(error: Error) {
        switch error {
        case MagicNetworkProvider.MagicNetworkError.pageLoadError:
            showCustomModalAlert(view, title: "Error loading data",
                                 content: "An error ocurred loading cards.\nPlease, try it again later.\nThank you.",
                                 completion: nil)
        default:
            showCustomModalAlert(view, title: "Error", content: "Please, try it again later.\nThank you.", completion: nil)
        }
        
    }
    
}
