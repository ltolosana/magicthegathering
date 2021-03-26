//
//  PhotoPlayerPresenter.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 26/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class PhotoPlayerPresenter: BasePresenter, PhotoPlayerPresenterContract {

    weak var view: PhotoPlayerViewContract!
    var interactor: PhotoPlayerInteractorContract!
    var entity: PhotoPlayerEntityContract!
    var wireframe: PhotoPlayerWireframeContract!

    func viewDidLoad() {
        view.setUpNavigationTitle(title: "Choose a photo")
    }

    func viewWillAppear() {

    }
}

// MARK: - PhotoPlayerInteractorOutputContract
extension PhotoPlayerPresenter: PhotoPlayerInteractorOutputContract {
    
}

// MARK: - PhotoPlayerWireframeOutputContract
extension PhotoPlayerPresenter: PhotoPlayerWireframeOutputContract {
    
}
