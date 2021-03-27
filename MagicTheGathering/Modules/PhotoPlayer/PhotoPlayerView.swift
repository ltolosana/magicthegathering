//
//  PhotoPlayerView.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 26/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import PhotosUI

class PhotoPlayerView: BaseViewController, PhotoPlayerViewContract {

    @IBOutlet weak var photoImageView: UIImageView!
    
    var presenter: PhotoPlayerPresenterContract!

	// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }

    func setUpNavigationTitle(title: String) {
        self.navigationItem.title = title
        setUpNavigationTitleFont(fontSize: 24, color: .label)
    }
    
    func setUpTabBar(title: String) {
        let icon = UIImage(systemName: "photo")
        tabBarItem = UITabBarItem(title: title, image: icon, tag: 2)
        tabBarItem.selectedImage = icon?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        setUpTabBarItemFont(fontSize: 16, color: .systemGreen)
    }
    
    private func setupView() {

    }
    
    // MARK: - Actions
    @IBAction func tapAction(_ sender: Any) {
        presenter.tappedForPhoto()
    }
    
    func createPicker() -> PHPickerViewController {
        var pickerConfiguration = PHPickerConfiguration()
        pickerConfiguration.filter = .images
        let pickerVC = PHPickerViewController(configuration: pickerConfiguration)
        
        pickerVC.delegate = self
        return pickerVC
    }
}

extension PhotoPlayerView: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        presenter.hidePicker()
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            let previousImage = photoImageView.image
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                
                DispatchQueue.main.async {
                    if error != nil, let self = self {
                        self.presenter.showPhotoError()
                        return
                    }
                    guard let self = self, let image = image as? UIImage, self.photoImageView.image == previousImage else {
                        return
                    }
                    self.photoImageView.image = image
                }
                
            }
        }
    }
}
