//
//  CardDetailBuilder.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 22/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class CardDetailBuilder {

    static func build(card: Card) -> CardDetailView {
        let view = CardDetailView.init(nibName: String(describing: CardDetailView.self), bundle: nil)
        let presenter = CardDetailPresenter()
        let entity = CardDetailEntity()
        let wireframe = CardDetailWireframe()
        
        let provider = MagicNetworkProvider()
        let interactor = CardDetailInteractor(provider: provider)
        
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
