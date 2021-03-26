//
//  PhotoPlayerInteractor.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 26/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class PhotoPlayerInteractor: BaseInteractor, PhotoPlayerInteractorContract {
    weak var output: PhotoPlayerInteractorOutputContract!

    var photoPlayerProvider: PhotoPlayerProviderContract
    
    init (provider: PhotoPlayerProviderContract) {
        self.photoPlayerProvider = provider
    }
}
