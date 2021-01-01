//
//  K.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit
import Moya
import Nuke

enum K {
    static let baseURL = "https://api.themoviedb.org/3"
    
    enum Components {
        static let navigationBarHeight: CGFloat = 64
    }
    
    enum ServicesPath {
        static let token = URL(string: "\(baseURL)/authentication/token/new")!
        static let validateWithLogin = URL(string: "\(baseURL)/authentication/token/validate_with_login")!
    }
    
    
    // Moya
    enum MoyaDefaults {
        static let plugins: [PluginType] = [
            NetworkLoggerPlugin(),
            SecureRequestPlugin()
        ]
        static let secureMethods: [Moya.Method] = [.get, .post]
        
        static let defaultHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(DefaultPreferences.current.accessToken ?? "")",
        ]
    }
    
    //Validations
    enum Validations {
        static let minPasswordLenght: UInt = 8
        static let maxPasswordLenght: UInt = 24
        static let maxUsernameLenght: UInt = 30
        static let minUsernameLenght: UInt = 4
        static let maxNameLenght: UInt = 30
        static let minNameLenght: UInt = 2
    }
    
    enum NukeDefault {
        static let options = ImageLoadingOptions(
            placeholder: R.Base.placeholder.image,
            transition: .fadeIn(duration: 0.33),
            failureImage: R.Base.noImageAvailable.image
        )
    }
}

