//
//  NewPlayerFormBuilder.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class NewPlayerFormBuilder {

    static func build() -> NewPlayerFormView {
        let view = NewPlayerFormView.init(nibName: String(describing: NewPlayerFormView.self), bundle: nil)
        view.tabBarItem = UITabBarItem(title: "New Player Registration", image: UIImage(systemName: "person"), tag: 1)
        let presenter = NewPlayerFormPresenter()
        let entity = NewPlayerFormEntity()
        let wireframe = NewPlayerFormWireframe()
        
        let provider = MagicNetworkProvider()
        let interactor = NewPlayerFormInteractor(provider: provider)
        
        view.presenter = presenter
        view.presenter.view = view
        view.presenter.entity = entity
        view.presenter.interactor = interactor
        view.presenter.interactor.output = presenter
        view.presenter.wireframe = wireframe
        
        view.presenter.wireframe.output = presenter
        view.presenter.wireframe.view = view
        
        return view
    }
}
