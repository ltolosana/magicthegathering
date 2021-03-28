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
        view.setUpNavigationTitle(title: "New Player Registration")
        view.addObservers()
    }

    func viewWillAppear() {

    }
    
    func viewWillDisappear() {
        view.removeObservers()
    }
    
    func onCheckTextFieldNumWords(_ text: String, minWords: Int) -> Bool {
        interactor.checkTextFieldNumWords(text, minWords: minWords)
    }
    
    func onCheckPhoneDigits(_ text: String) -> Bool {
        interactor.checkPhoneDigits(text)
    }
    
    func onCheckEmail(_ text: String) -> Bool {
        interactor.checkEmail(text)
    }
    
    func onCheckSameTextInput(_ text: String, vs otherText: String) -> Bool {
        interactor.checkSameTextInput(text, vs: otherText)
    }

    func onCheckPasswordConstraints(_ text: String, minCharacters: Int) -> Bool {
        interactor.checkPasswordConstraints(text, minCharacters: minCharacters)
    }
    
    func onCheckPhoneNumber(range: NSRange, string: String) -> Bool {
        interactor.checkPhoneNumber(range: range, string: string)
    }
    
    func onCheckForWhiteSpaces(string: String) -> Bool {
        interactor.checkForWhiteSpaces(string: string)
    }

}

// MARK: - NewPlayerFormInteractorOutputContract
extension NewPlayerFormPresenter: NewPlayerFormInteractorOutputContract {
    
}

// MARK: - NewPlayerFormWireframeOutputContract
extension NewPlayerFormPresenter: NewPlayerFormWireframeOutputContract {
    
}
