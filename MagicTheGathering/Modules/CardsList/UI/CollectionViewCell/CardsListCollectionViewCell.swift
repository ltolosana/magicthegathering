//
//  CardsListCollectionViewCell.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 21/3/21.
//

import UIKit
import SDWebImage

class CardsListCollectionViewCell: UICollectionViewCell {

    static let cellId = "CardsListCollectionViewCell"
    
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpData(card: Card) {
        if let url = URL(string: card.getImageURL()) {
            cardImageView.sd_setImage(with: url, completed: nil)
            
        } else {
            cardImageView.image = UIImage(systemName: "questionmark.square")
        }
        
        cardNameLabel.text = card.getName()
    }

}
