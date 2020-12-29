//
//  K.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit
import Moya

enum K {
    static let baseURL = ""
    
    enum Components {
        static let navigationBarHeight: CGFloat = 64
    }
    
    enum ServicesPath {
        static let token = URL(string: "\(baseURL)/Token")!
        static let inquery = URL(string: "\(baseURL)/Clientes")!
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
        ]
    }
    
    //Validations
    enum Validations {
        static let maxNameLenght: UInt = 30
        static let minNameLenght: UInt = 2
    }
}

