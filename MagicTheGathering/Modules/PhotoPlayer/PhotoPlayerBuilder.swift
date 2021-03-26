//
//  PhotoPlayerBuilder.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 26/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class PhotoPlayerBuilder {

    static func build() -> PhotoPlayerView {
        let view = PhotoPlayerView.init(nibName: String(describing: PhotoPlayerView.self), bundle: nil)
        view.setUpTabBar(title: "Photo Player")

        let presenter = PhotoPlayerPresenter()
        let entity = PhotoPlayerEntity()
        let wireframe = PhotoPlayerWireframe()
        
        let provider = PhotoPlayerProvider()
        let interactor = PhotoPlayerInteractor(photoProvider: provider)
        
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
