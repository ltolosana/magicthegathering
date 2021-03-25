//
//  CardDetailView.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 22/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class CardDetailView: BaseViewController, CardDetailViewContract {
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var manaLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var rarityLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var toughnessLabel: UILabel!
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var propertiesStackView: UIStackView!
    @IBOutlet weak var attributesStackView: UIStackView!
    
    var presenter: CardDetailPresenterContract!
    
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
    
    private func setupView() {
        // Como este es un metodo unicamente de configuracion de la UI,
        // he preferido meterlo aqui en vez de que sea el presenter el que lo invoque
        // Creo que es mas correcto asi, no?
        configureStackViews()
    }
    
    func setUpNavigationTitle(title: String) {
        self.title = title
        setUpNavigationTitleFont(fontSize: 24, color: .systemRed)
    }
    
    func reloadViewWithData(card: Card) {
        if let url = URL(string: card.getImageURL()) {
            cardImageView.sd_setImage(with: url, completed: nil)
            
        } else {
            cardImageView.image = UIImage(named: Constants.placeholderMagicCard)
        }
        
        populateData(card: card)
    }
    
    func configureStackViews() {
        if traitCollection.verticalSizeClass == .regular {
            portraitConfigurationStackViews()
        } else if traitCollection.verticalSizeClass == .compact {
            landscapeConfigurationStackViews()
        }
    }
    
    // MARK: - Private funcs
    private func populateData(card: Card) {
        textLabel.text = card.getText()
        typeLabel.text = card.getType()
        manaLabel.text = card.getManaCost()
        colorLabel.text = card.getColors()
        rarityLabel.text = card.getRarity()
        powerLabel.text = card.getPower()
        toughnessLabel.text = card.getToughness()
    }
    
    private func portraitConfigurationStackViews() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = 20
        propertiesStackView.axis = .vertical
        propertiesStackView.alignment = .fill
        propertiesStackView.distribution = .fill
        propertiesStackView.spacing = 10
        attributesStackView.axis = .horizontal
        attributesStackView.alignment = .fill
        attributesStackView.distribution = .fill
        attributesStackView.spacing = 20
    }
    private func landscapeConfigurationStackViews() {
        mainStackView.axis = .horizontal
        mainStackView.alignment = .top
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 20
        propertiesStackView.axis = .vertical
        propertiesStackView.alignment = .fill
        propertiesStackView.distribution = .fill
        propertiesStackView.spacing = 10
        attributesStackView.axis = .vertical
        attributesStackView.alignment = .leading
        attributesStackView.distribution = .fill
        attributesStackView.spacing = 10
    }
}

// MARK: - Override methods
extension CardDetailView {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        configureStackViews()
    }
}
