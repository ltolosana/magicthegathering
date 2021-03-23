//
//  CardsListBuilder.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 21/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class CardsListBuilder {

    static func build() -> CardsListView {
        let view = CardsListView.init(nibName: String(describing: CardsListView.self), bundle: nil)
        let presenter = CardsListPresenter()
        let entity = CardsListEntity()
        let wireframe = CardsListWireframe()
        
        let provider = MagicNetworkProvider()
        let interactor = CardsListInteractor(magicProvider: provider)
        
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
