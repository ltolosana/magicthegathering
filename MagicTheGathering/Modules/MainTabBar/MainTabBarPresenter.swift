//
//  MainTabBarPresenter.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class MainTabBarPresenter: BasePresenter, MainTabBarPresenterContract {

    weak var view: MainTabBarViewContract!
    var interactor: MainTabBarInteractorContract!
    var entity: MainTabBarEntityContract!
    var wireframe: MainTabBarWireframeContract!

    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
    
    func getTabBarViewController() -> [UIViewController] {
        let cardsListVC = CardsListBuilder.build()
        let cardsNavigationVC = UINavigationController(rootViewController: cardsListVC)
        cardsNavigationVC.setUpTabBarItemFont(fontSize: 16, color: UIColor.systemRed)

        let newPlayerVC = NewPlayerFormBuilder.build()
        let newPlayerNavigationVC = UINavigationController(rootViewController: newPlayerVC)
        newPlayerNavigationVC.setUpTabBarItemFont(fontSize: 16, color: UIColor.systemBlue)
        
        return [cardsNavigationVC, newPlayerNavigationVC]
    }
}

// MARK: - MainTabBarInteractorOutputContract
extension MainTabBarPresenter: MainTabBarInteractorOutputContract {
    
}

// MARK: - MainTabBarWireframeOutputContract
extension MainTabBarPresenter: MainTabBarWireframeOutputContract {
    
}
