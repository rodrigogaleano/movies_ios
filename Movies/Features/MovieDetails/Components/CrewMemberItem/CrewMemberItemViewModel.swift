//
//  CrewMemberItemViewModel.swift
//  Movies
//
//  Created by Rodrigo Galeano on 06/12/24.
//

import Foundation

class CrewMemberItemViewModel {
    private let crewMember: CrewMember
    
    init(crewMember: CrewMember) {
        self.crewMember = crewMember
    }
}

extension CrewMemberItemViewModel: CrewMemberItemViewModelProtocol {
    var name: String {
        self.crewMember.name
    }
    
    var job: String {
        self.crewMember.job
    }
    
    var imageURL: URL? {
        self.crewMember.profileImageURL
    }
}
