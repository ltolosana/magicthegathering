//
//  PhotoPlayerInteractor.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 26/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

class PhotoPlayerInteractor: BaseInteractor, PhotoPlayerInteractorContract {
    
    enum PhotoPlayerError: Error {
        case notAuthorized
    }
    
    enum Status {
        case denied, authorized, other
    }
    
    weak var output: PhotoPlayerInteractorOutputContract!
    
    var photoPlayerProvider: PhotoPlayerProviderContract
    
    init (photoProvider: PhotoPlayerProviderContract) {
        self.photoPlayerProvider = photoProvider
    }
    
    func accessPhotoLibrary() -> Promise<Bool> {

        return Promise<Bool> { promise in
            firstly {
                // Primero llamamos al provider para que nos diga si ya tenemos autorizacion para acceder a la libreria de fotos
                photoPlayerProvider.accessPhotoLibraryEnabled(for: .readWrite)
            }.done { status in
                switch status {
                
                case .authorized:
                    // Si tiene autorizacion, genial!!!
                    promise.fulfill(true)
                case .denied:
                    // El permiso estaba denegado, asi que malamente!!!
                    promise.fulfill(false)
                case .other:
                    // Si no tiene autorizacion establecida, solicitamos al usuario que nos autorice a acceder a las fotos
                    self.photoPlayerProvider.requestAuthorization(for: .readWrite).done { success in
                        if success {
                            // Si nos da permiso, genial!!
                            promise.fulfill(true)
                        } else {
                            // Si no nos da permiso, peor para el
                            promise.fulfill(false)
                        }
                    }.catch { _ in
                        promise.fulfill(false)
                    }
                }
            }.catch { _ in
                promise.fulfill(false)
            }
        }
    }
}
