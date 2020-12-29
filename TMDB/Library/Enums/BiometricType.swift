//
//  BiometricType.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import Foundation

enum BiometricType {
    case none
    case touchID
    case faceID
}

extension BiometricType {
    
    // MARK: - Disable Texts
    
    var inactivationTitle: String? {
        switch self {
        case .faceID: return ""
        case .touchID: return ""
        case .none: return nil
        }
    }
    
    // MARK: - Enable Texts
    
    var enableTitle: String?  {
        switch self {
        case .faceID: return ""
        case .touchID: return ""
        case .none: return nil
        }
    }
    
    var activationTitle: String? {
        switch self {
        case .faceID: return ""
        case .touchID: return ""
        case .none: return nil
        }
    }
    
    var activationSubTitle: String? {
        switch self {
        case .faceID: return ""
        case .touchID: return ""
        case .none: return nil
        }
    }
    
    var icon: String? {
        switch self {
        case .faceID: return "faceID"
        case .touchID: return "touchID"
        case .none: return nil
        }
    }
}
