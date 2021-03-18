//
//  Card.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 17/3/21.
//

import Foundation
import ObjectMapper

protocol CardModel {
    
    func getId() -> String
    func getName() -> String
    func getManaCost() -> String
    func getColors() -> String
    func getType() -> String
    func getRarity() -> String
    func getText() -> String
    func getPower() -> String
    func getToughness() -> String
    func getImageURL() -> String
}

struct Card: ImmutableMappable {
    
    private let id: String
    private let name: String
    private let manaCost: String
    private let colors: [String]
    private let type: String
    private let rarity: String
    private let text: String
    private let power: String?
    private let toughness: String?
    private let imageURL: String?
    
    init(map: Map) throws {
        
        id = try map.value("id")
        name = try map.value("name")
        manaCost = try map.value("manaCost")
        colors = try map.value("colors")
        type = try map.value("type")
        rarity = try map.value("rarity")
        text = try map.value("text")
        power = try? map.value("power")
        toughness = try? map.value("toughness")
        imageURL = try map.value("imageUrl")
    }
    
    // A priori no se va a usar en el proyecto, pero la dejo ya implementada para el futuro
    func mapping(map: Map) {
        id >>> map["id"]
        name >>> map["name"]
        manaCost >>> map["manaCost"]
        colors >>> map["colors"]
        type >>> map["type"]
        rarity >>> map["rarity"]
        text >>> map["text"]
        power >>> map["power"]
        toughness >>> map["toughness"]
        imageURL >>> map["imageUrl"]
    }
}

extension Card: CardModel {
    
    static let notApplicable = "-"
    static let emptyImage = ""
    
    func getId() -> String {
        return id
    }
    
    func getName() -> String {
        return name
    }
    
    func getManaCost() -> String {
        return manaCost
    }
    
    func getColors() -> String {
        return colors.joined(separator: ", ")
    }
    
    func getType() -> String {
        return type
    }
    
    func getRarity() -> String {
        return rarity
    }
    
    func getText() -> String {
        return text
    }
    
    func getPower() -> String {
        return power ?? Card.notApplicable
    }
    
    func getToughness() -> String {
        return toughness ?? Card.notApplicable
    }
    
    func getImageURL() -> String {
        return imageURL ?? Card.emptyImage
    }
}
