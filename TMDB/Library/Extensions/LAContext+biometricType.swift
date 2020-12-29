//
//  LAContext+biometricType.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import LocalAuthentication

extension LAContext {
    var biometricType: BiometricType {
        var error: NSError?

        guard self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
            else { return .none }

        if #available(iOS 11.0, *) {
            switch self.biometryType {
            case .none:
                return .none
                
            case .touchID:
                return .touchID
                
            case .faceID:
                return .faceID
                
            default:
                return .none
            }
        } else {
            return self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
        }
    }
}
