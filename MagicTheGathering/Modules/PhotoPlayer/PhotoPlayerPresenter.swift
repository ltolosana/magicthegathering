//
//  PhotoPlayerPresenter.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 26/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

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
    
    func tappedForPhoto() {
        // Primero le pido al interactor que me de lo necesario para poder mostrar una foto y cuando lo tenga
        // luego le tendre que decir al wireframe que presente la vista con lo que tenga que presentar
        firstly {
            interactor.accessPhotoLibrary()
        }.done { result in
            if result {
                print("Tengo autorizacion")
            } else {
                print("NO AUTORIZADO")
            }
        }.catch { error in
            print("Algo ha ido mal: \(error).")
        }
    }
}

// MARK: - PhotoPlayerInteractorOutputContract
extension PhotoPlayerPresenter: PhotoPlayerInteractorOutputContract {
    
}

// MARK: - PhotoPlayerWireframeOutputContract
extension PhotoPlayerPresenter: PhotoPlayerWireframeOutputContract {
    
}
