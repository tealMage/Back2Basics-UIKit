//
//  Influencer.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/9/21.
//

import Foundation
struct Influencer: Encodable, Equatable {
    
    let guid: String
    let username: String
    let description: String
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case guid
        case username
        case description
        case url
    }
    
    init(guid: String,
         name: String,
         description: String,
         url: URL) {
        self.guid = guid
        self.username = name
        self.description = description
        self.url = url
    }
    
}

extension Influencer: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        guid  = try values.decodeIfPresent(String.self, forKey: .guid) ?? ""
        username  = try values.decodeIfPresent(String.self, forKey: .username) ?? ""
        description  = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        url  = try values.decode(URL.self, forKey: .url)
    }

}
