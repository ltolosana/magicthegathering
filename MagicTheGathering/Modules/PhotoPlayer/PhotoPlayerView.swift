//
//  PhotoPlayerView.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 26/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

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
    
    @IBAction func tapAction(_ sender: Any) {
        print("ACTION")
    }

}
