//
//  CardsListInteractor.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 21/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

class CardsListInteractor: BaseInteractor, CardsListInteractorContract {
    weak var output: CardsListInteractorOutputContract!

    var magicProvider: MagicProviderContract
    
    init (magicProvider: MagicProviderContract) {
        self.magicProvider = magicProvider
    }
    
    // MARK: - Public Methods
    func getCardsList() -> Promise<[Card]> {
        return self.magicProvider.getCards()
    }   
}
