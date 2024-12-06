//
//  CastMemberItemViewModel.swift
//  Movies
//
//  Created by Rodrigo Galeano on 02/12/24.
//

import Foundation

class CastMemberItemViewModel {
    private let castMember: CastMember
    
    init(castMember: CastMember) {
        self.castMember = castMember
    }
}

extension CastMemberItemViewModel: CastMemberItemViewModelProtocol {
    var name: String {
        self.castMember.name
    }
    
    var character: String {
        self.castMember.character
    }
    
    var imageURL: URL? {
        self.castMember.profileImageURL
    }
}
