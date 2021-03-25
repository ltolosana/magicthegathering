//
//  NewPlayerFormInteractor.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class NewPlayerFormInteractor: BaseInteractor, NewPlayerFormInteractorContract {
    weak var output: NewPlayerFormInteractorOutputContract!

    var magicProvider: MagicProviderContract
    
    init (provider: MagicProviderContract) {
        self.magicProvider = provider
    }
}
