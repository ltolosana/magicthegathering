//
//  CardDetailInteractor.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 22/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class CardDetailInteractor: BaseInteractor, CardDetailInteractorContract {
    weak var output: CardDetailInteractorOutputContract!

    var magicNetworkProvider: MagicProviderContract
    
    init (provider: MagicProviderContract) {
        self.magicNetworkProvider = provider
    }
}
