//
//  NewPlayerFormContract.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol NewPlayerFormEntityContract: BaseEntity {
    
}

protocol NewPlayerFormViewContract: BaseViewController {
    var presenter: NewPlayerFormPresenterContract! { get set }
    
    func setUpNavigationTitle(title: String)
    func setUpTabBar(title: String)
    
    func addObservers()
    func removeObservers()
}

protocol NewPlayerFormPresenterContract: BasePresenter {
    var view: NewPlayerFormViewContract! { get set }
    var interactor: NewPlayerFormInteractorContract! { get set }
    var entity: NewPlayerFormEntityContract! { get set }
    var wireframe: NewPlayerFormWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    
    func onCheckTextFieldNumWords(_ text: String, minWords: Int) -> Bool
    func onCheckPhoneDigits(_ text: String) -> Bool
    func onCheckEmail(_ text: String) -> Bool
    func onCheckSameTextInput(_ text: String, vs otherText: String) -> Bool
    func onCheckPasswordConstraints(_ text: String, minCharacters: Int) -> Bool
    func onCheckPhoneNumber(range: NSRange, string: String) -> Bool
    func onCheckForWhiteSpaces(string: String) -> Bool
}

protocol NewPlayerFormInteractorContract: BaseInteractor {
    var output: NewPlayerFormInteractorOutputContract! {get set}
    
    func checkTextFieldNumWords(_ text: String, minWords: Int) -> Bool
    func checkPhoneDigits(_ text: String) -> Bool
    func checkEmail(_ text: String) -> Bool
    func checkSameTextInput(_ text: String, vs otherText: String) -> Bool
    func checkPasswordConstraints(_ text: String, minCharacters: Int) -> Bool
    func checkPhoneNumber(range: NSRange, string: String) -> Bool
    func checkForWhiteSpaces(string: String) -> Bool
}

protocol NewPlayerFormInteractorOutputContract: class {
    
}

protocol NewPlayerFormWireframeContract: BaseWireframe {
    var output: NewPlayerFormWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
    
    func showBasicLoading(text: String)
    func hideBasicLoading(completion: @escaping (() -> Void))
}

protocol NewPlayerFormWireframeOutputContract: class {

}
