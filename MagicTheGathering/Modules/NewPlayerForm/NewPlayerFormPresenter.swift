//
//  NewPlayerFormPresenter.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class NewPlayerFormPresenter: BasePresenter, NewPlayerFormPresenterContract {

    weak var view: NewPlayerFormViewContract!
    var interactor: NewPlayerFormInteractorContract!
    var entity: NewPlayerFormEntityContract!
    var wireframe: NewPlayerFormWireframeContract!

    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
}

// MARK: - NewPlayerFormInteractorOutputContract
extension NewPlayerFormPresenter: NewPlayerFormInteractorOutputContract {
    
}

// MARK: - NewPlayerFormWireframeOutputContract
extension NewPlayerFormPresenter: NewPlayerFormWireframeOutputContract {
    
}
