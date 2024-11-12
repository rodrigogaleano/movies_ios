//
//  CastMember.swift
//  Movies
//
//  Created by Rodrigo Galeano on 12/11/24.
//

import Foundation

struct CastMemberResult: Decodable {
    var cast: [CastMember]
}

struct CastMember: Decodable {
    var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case profilePath = "profile_path"
    }
    
    var profileImageURL: URL? {
        guard let path = profilePath else { return nil }
        
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}

//"adult": false,
//"gender": 2,
//"id": 2524,
//"known_for_department": "Acting",
//"name": "Tom Hardy",
//"original_name": "Tom Hardy",
//"popularity": 107.764,
//"profile_path": "/d81K0RH8UX7tZj49tZaQhZ9ewH.jpg",
//"cast_id": 1,
//"character": "Eddie Brock / Venom",
//"credit_id": "61aecf46a242320089aafb19",
//"order": 0
