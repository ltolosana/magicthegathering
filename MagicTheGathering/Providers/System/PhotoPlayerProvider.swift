//
//  PhotoPlayerProvider.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 26/3/21.
//

import Foundation
import Photos
import PromiseKit

protocol PhotoPlayerProviderContract {
    func accessPhotoLibraryEnabled(for accessLevel: PHAccessLevel) -> Promise<PhotoPlayerInteractor.Status>
    func requestAuthorization(for accessLevel: PHAccessLevel) -> Promise<Bool>
}

class PhotoPlayerProvider: PhotoPlayerProviderContract {
    
    func accessPhotoLibraryEnabled(for accessLevel: PHAccessLevel) -> Promise<PhotoPlayerInteractor.Status> {
        return Promise<PhotoPlayerInteractor.Status> { promise in
            let status = PHPhotoLibrary.authorizationStatus(for: accessLevel)
            switch status {
            case .authorized, .limited:
                // Ya teniamos habilitado el acceso a la galeria de fotos (a toda o solo a parte)
                promise.fulfill(.authorized)
            case .denied:
                // Ya teniamos denegado el acceso a la galeria de fotos
                promise.fulfill(.denied)
            default:
                // No teniamos establecida una politica de acceso (o el sistema la tiene restringida por algun motivo)
                promise.fulfill(.other)
            }
        }
    }
    
    func requestAuthorization(for accessLevel: PHAccessLevel) -> Promise<Bool> {
        return Promise<Bool> { promise in
            PHPhotoLibrary.requestAuthorization(for: accessLevel) { (status) in
                switch status {
                case .authorized, .limited:
                    // El usuario nos da permiso a todas las fotos o solo a algunas
                    promise.fulfill(true)
                default:
                    // El usuario NO nos ha dado permiso o el sistema nos ha restringido por algun motivo
                    promise.fulfill(false)
                }
            }
        }
    }
}
