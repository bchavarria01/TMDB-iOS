//
//  ActionModalType.swift
//  TMDB
//
//  Created by Byron Chavarría on 3/1/21.
//

import Foundation

enum ActionModalType {
    case exception(description: String)
    case success(description: String)
}

// MARK: - ActionableModal

extension ActionModalType: ActionableModal {
    var title: String {
        switch self {
        case .exception:
            return "Error"
            
        case .success:
            return "Ok"
        }
    }
    
    var desctiption: String {
        switch self {
        case let .exception(description):
            return description
            
        case let .success(description):
            return description
        }
    }
    
    var actionTitle: String {
        switch self {
        case .exception, .success:
            return "Continue"
        }
    }
}

