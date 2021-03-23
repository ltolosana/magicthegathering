//
//  MainTabBarBuilder.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class MainTabBarBuilder {
    
    static func build() -> MainTabBarView {
        let view = MainTabBarView.init(nibName: String(describing: MainTabBarView.self), bundle: nil)
        return view
    }
    
    static func setupPresenter(view: MainTabBarViewContract) {
        let presenter = MainTabBarPresenter()
        let entity = MainTabBarEntity()
        let wireframe = MainTabBarWireframe()
        
        let interactor = MainTabBarInteractor()
        
        view.presenter = presenter
        view.presenter.view = view
        view.presenter.entity = entity
        view.presenter.interactor = interactor
        view.presenter.interactor.output = presenter
        view.presenter.wireframe = wireframe
        
        view.presenter.wireframe.output = presenter
        view.presenter.wireframe.view = view
    }
}
