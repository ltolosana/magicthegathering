//
//  PhotoPlayerContract.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 26/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol PhotoPlayerEntityContract: BaseEntity {
    
}

protocol PhotoPlayerViewContract: BaseViewController {
    var presenter: PhotoPlayerPresenterContract! { get set }
    
    func setUpNavigationTitle(title: String)
    func setUpTabBar(title: String)
}

protocol PhotoPlayerPresenterContract: BasePresenter {
    var view: PhotoPlayerViewContract! { get set }
    var interactor: PhotoPlayerInteractorContract! { get set }
    var entity: PhotoPlayerEntityContract! { get set }
    var wireframe: PhotoPlayerWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
}

protocol PhotoPlayerInteractorContract: BaseInteractor {
    var output: PhotoPlayerInteractorOutputContract! {get set}
}

protocol PhotoPlayerInteractorOutputContract: class {
    
}

protocol PhotoPlayerWireframeContract: BaseWireframe {
    var output: PhotoPlayerWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
    
    func showBasicLoading(text: String)
    func hideBasicLoading(completion: @escaping (() -> Void))
}

protocol PhotoPlayerWireframeOutputContract: class {

}
