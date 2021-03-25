//
//  MainTabBarContract.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol MainTabBarEntityContract: BaseEntity {
    
}

protocol MainTabBarViewContract: BaseTabBarController {
    var presenter: MainTabBarPresenterContract! { get set }
    
}

protocol MainTabBarPresenterContract: BasePresenter {
    var view: MainTabBarViewContract! { get set }
    var interactor: MainTabBarInteractorContract! { get set }
    var entity: MainTabBarEntityContract! { get set }
    var wireframe: MainTabBarWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
    
    func getTabBarViewController() -> [BaseNavigationController]
}

protocol MainTabBarInteractorContract: BaseInteractor {
    var output: MainTabBarInteractorOutputContract! {get set}
}

protocol MainTabBarInteractorOutputContract: class {
    
}

protocol MainTabBarWireframeContract: BaseWireframe {
    var output: MainTabBarWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
    
    func showBasicLoading(text: String)
    func hideBasicLoading(completion: @escaping (() -> Void))
    
    func embedInNavigation(_ destination: UIViewController) -> BaseNavigationController
}

protocol MainTabBarWireframeOutputContract: class {

}
