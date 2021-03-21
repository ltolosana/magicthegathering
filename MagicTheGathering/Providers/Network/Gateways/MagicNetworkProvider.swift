//
//  MagicNetworkProvider.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 18/3/21.
//

import Foundation
import PromiseKit
import Alamofire

protocol MagicProviderContract {
    func getCards() -> Promise<[Card]>
}

class MagicNetworkProvider: BaseNetworkProvider, MagicProviderContract {
    private let fullPathCardsURL = {
        Environment.appRootURL.appendingPathComponent(NetworkConstants.kAPIV1CardsURLPath)
    }
    
    enum MagicNetworkError: Error {
        case pageLoadError
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
}
