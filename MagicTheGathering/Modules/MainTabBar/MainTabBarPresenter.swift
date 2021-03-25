//
//  MainTabBarPresenter.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class MainTabBarPresenter: BasePresenter, MainTabBarPresenterContract {

    weak var view: MainTabBarViewContract!
    var interactor: MainTabBarInteractorContract!
    var entity: MainTabBarEntityContract!
    var wireframe: MainTabBarWireframeContract!

    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
    
    func getTabBarViewController() -> [BaseNavigationController] {
        let cardsListVC = CardsListBuilder.build()
        let cardsNavigationVC = wireframe.embedInNavigation(cardsListVC)

        let newPlayerVC = NewPlayerFormBuilder.build()
        let newPlayerNavigationVC = wireframe.embedInNavigation(newPlayerVC)

        return [cardsNavigationVC, newPlayerNavigationVC]
    }
}

// MARK: - MainTabBarInteractorOutputContract
extension MainTabBarPresenter: MainTabBarInteractorOutputContract {
    
}

// MARK: - MainTabBarWireframeOutputContract
extension MainTabBarPresenter: MainTabBarWireframeOutputContract {
    
}
