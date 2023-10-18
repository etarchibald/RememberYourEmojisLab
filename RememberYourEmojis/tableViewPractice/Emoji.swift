//
//  Emoji.swift
//  tableViewPractice
//
//  Created by Ethan Archibald on 10/13/23.
//

import Foundation

var documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
var archiveURL = documentsDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")

struct Emoji: Codable {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static func saveToFile(emojis: [Emoji]) {
        let propertyListEncoder = PropertyListEncoder()
        let encoded = try? propertyListEncoder.encode(emojis)
        try? encoded?.write(to: archiveURL)
    }
    
    static func loadFromFile() -> [Emoji] {
        let propertyListDecoder = PropertyListDecoder()
        if let retrived = try? Data(contentsOf: archiveURL),
           let decoded = try? propertyListDecoder.decode(Array<Emoji>.self, from: retrived) {
            return decoded
        }
        return []
    }
    
    static func sampleEmojis() -> [Emoji] {
        let emoji: [Emoji] = [
            Emoji(symbol: "🤡", name: "Clown Face", description: "You", usage: "Describe your friends")]
        return emoji
    }
    
}
