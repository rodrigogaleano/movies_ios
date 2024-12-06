//
//  CrewMember.swift
//  Movies
//
//  Created by Rodrigo Galeano on 02/12/24.
//

import Foundation

struct CrewMember: Decodable {
    var job: String
    var name: String
    var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case job
        case name
        case profilePath = "profile_path"
    }
    
    var profileImageURL: URL? {
        guard let path = profilePath else { return nil }
        
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}
