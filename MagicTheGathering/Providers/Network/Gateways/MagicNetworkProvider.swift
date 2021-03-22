//
//  MagicNetworkProvider.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 18/3/21.
//

import Foundation
import PromiseKit
import Alamofire
import AlamofireImage

protocol MagicProviderContract {
    func getCards() -> Promise<[Card]>
    func getCardImage(stringURL: String) -> Promise<UIImage>
}

class MagicNetworkProvider: BaseNetworkProvider, MagicProviderContract {
    private let fullPathCardsURL = {
        Environment.appRootURL.appendingPathComponent(NetworkConstants.kAPIV1CardsURLPath)
    }
    
    enum MagicNetworkError: Error {
        case pageLoadError
        case badImageURL
        case imageNotFound
    }
    
    func getCards() -> Promise<[Card]> {
        var cards: [Card] = []
        
        return Promise<[Card]> { promise in
            
            AF.request(fullPathCardsURL()).responseJSON { response in
                do {
                    let responseData = try response.result.get() as? [String: Any]
                    guard let results = responseData?["cards"] as? [[String: Any]] else {
                        promise.reject(MagicNetworkError.pageLoadError)
                        return }
                    for result in results {
                        do {
                            let card = try Card(JSON: result)
                            cards.append(card)
                        } catch {
                            fatalError("Error processing card: \(error)")
                        }
                    }
                    promise.fulfill(cards)
                    
                } catch {
                    promise.reject(NetworkError.badResponse)
                }
            }
        }
    }
    
    func getCardImage(stringURL: String) -> Promise<UIImage> {

        return Promise<UIImage> { promise in
            guard let url = URL(string: stringURL) else {
                promise.reject(MagicNetworkError.badImageURL)
                return
            }
            AF.request(url).responseImage { response in

                switch response.result {
                case .success(let image):
                    promise.fulfill(image)
                case .failure:
                    promise.reject(MagicNetworkError.imageNotFound)
                }
 
            }
        }
    }
}
