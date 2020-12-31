//
//  DefaultPreferences.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit

final class DefaultPreferences {
    
    // MARK: - Attributess
    
    static let current = DefaultPreferences()
    
    var accessToken: String?
    var requestToken: String?
    var loadImageBaseString: String?
    
    // MARK: - LifeCycle
    
    private init () {
        accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MzRlMjg2NGU2YTE4YmFkYmQwYTIwNjRlMTcwZDg2ZCIsInN1YiI6IjVmZWJhZGU3MDdhODA4MDA0MDkzMmFmYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aOBKGmpVjpUb1fKOFjATM4Ct2vpRk1SJEmnpdkTmZsI"
        requestToken = ""
        loadImageBaseString = "https://image.tmdb.org/t/p/w500"
    }
}
