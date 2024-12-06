//
//  CrewMember.swift
//  Movies
//
//  Created by Rodrigo Galeano on 02/12/24.
//

struct CrewMember: Decodable {
    var job: String
    var name: String
    var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case job
        case name
        case profilePath = "profile_path"
    }
}
