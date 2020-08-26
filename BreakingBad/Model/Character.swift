// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let characters = try? newJSONDecoder().decode(Characters.self, from: jsonData)

import Foundation

// MARK: - Character
struct Character: Codable {
    let charID: Int?
    let name: String?
    let birthday: String?
    let occupation: [String]?
    let img: String?
    let status: String?
    let nickname: String?
    let appearance: [Int]?
    let portrayed: String?
    let category: String?
    let betterCallSaulAppearance: [Int]?

    enum CodingKeys: String, CodingKey {
        case charID = "char_id"
        case name, birthday, occupation, img, status, nickname, appearance, portrayed, category
        case betterCallSaulAppearance = "better_call_saul_appearance"
    }
}

typealias Characters = [Character]

