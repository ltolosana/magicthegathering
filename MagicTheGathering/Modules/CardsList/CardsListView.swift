//
//  CardsListView.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 21/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class CardsListView: BaseViewController, CardsListViewContract {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: CardsListPresenterContract!
    
    var cards: [Card] = []
    
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

    // MARK: - Public methods
    func updateCardsData(cards: [Card]) {
        self.cards = cards
        collectionView.reloadData()
    }
       
    // MARK: - Private methods
    private func setupView() {
        collectionView.register(UINib(nibName: CardsListCollectionViewCell.cellId, bundle: nil),
                                forCellWithReuseIdentifier: CardsListCollectionViewCell.cellId)
        
        collectionView.dataSource = self
    }
}

extension CardsListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardsListCollectionViewCell.cellId,
                                                            for: indexPath) as? CardsListCollectionViewCell else {
            fatalError()
        }

        cell.setUpData(card: cards[indexPath.item])
        return cell
        
    }
    
}
