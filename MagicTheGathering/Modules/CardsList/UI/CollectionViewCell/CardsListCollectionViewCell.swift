//
//  CardsListCollectionViewCell.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 21/3/21.
//

import UIKit

class CardsListCollectionViewCell: UICollectionViewCell {

    static let cellId = "CardsListCollectionViewCell"
    
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpData(card: Card) {
        cardNameLabel.text = card.getName()
    }

}
