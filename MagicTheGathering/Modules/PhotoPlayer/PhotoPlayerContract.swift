//
//  PhotoPlayerContract.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 26/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit
import PhotosUI

protocol PhotoPlayerEntityContract: BaseEntity {
    
}

protocol PhotoPlayerViewContract: BaseViewController {
    var presenter: PhotoPlayerPresenterContract! { get set }
    
    func setUpNavigationTitle(title: String)
    func setUpTabBar(title: String)
    
    func createPicker() -> PHPickerViewController
    
}

protocol PhotoPlayerPresenterContract: BasePresenter {
    var view: PhotoPlayerViewContract! { get set }
    var interactor: PhotoPlayerInteractorContract! { get set }
    var entity: PhotoPlayerEntityContract! { get set }
    var wireframe: PhotoPlayerWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
    
    func tappedForPhoto()
    func hidePicker()
    func showPhotoError()
    func showPickerNotAuthorized()
}

protocol PhotoPlayerInteractorContract: BaseInteractor {
    var output: PhotoPlayerInteractorOutputContract! {get set}
    
    func accessPhotoLibrary() -> Promise<Bool>
}

protocol PhotoPlayerInteractorOutputContract: class {
    
}

protocol PhotoPlayerWireframeContract: BaseWireframe {
    var output: PhotoPlayerWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
    
    func showBasicLoading(text: String)
    func hideBasicLoading(completion: @escaping (() -> Void))
    
    func showPicker(picker: PHPickerViewController)
    func hidePicker()
}

protocol PhotoPlayerWireframeOutputContract: class {

}
