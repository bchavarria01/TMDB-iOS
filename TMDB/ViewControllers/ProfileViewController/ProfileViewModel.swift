//
//  ProfileViewModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 4/1/21.
//

import Foundation
import CoreData
import RxSwift

final class ProfileViewModel {
    
    // MARK: - Services
    
    let accountService: AccountService
    
    // MARK: - Attributes
    
    var context: NSManagedObjectContext!
    var isTest: Bool
    
    // MARK: - LifeCycle
    
    init(accountService: AccountService,
         context: NSManagedObjectContext,
         isTest: Bool) {
        self.accountService = accountService
        self.context = context
        self.isTest = isTest
    }
    
    // MARK: - Methods
    
    func getFavoritesTvShows() -> Single<[TvShowsModel]> {
        var localUserInfo: [UserInfo] = []
        var localSessions: [Session] = []
        let request = UserInfo.fetchRequest() as NSFetchRequest<UserInfo>
        let request2 = Session.fetchRequest() as NSFetchRequest<Session>
        do {
            localUserInfo = isTest ? [] : try self.context.fetch(request)
            localSessions = isTest ? [] : try self.context.fetch(request2)
        } catch {
            print(error.localizedDescription)
        }
        var userId = ""
        var sessionId = ""
        if localUserInfo.count > 0 {
            userId = localUserInfo[0].userId ?? ""
            sessionId = localSessions[0].sessionId ?? ""
        }
        return accountService.getFavortitesTvShows(with: userId, and: sessionId).map {
            var localTvShowList: [TvShowsModel] = []
            $0.results?.forEach({ tvShow in
                let tvShowModel = TvShowsModel()
                tvShowModel.id = tvShow.id
                tvShowModel.name = tvShow.name
                tvShowModel.overview = tvShow.overview
                tvShowModel.voteAverage = tvShow.voteAverage
                tvShowModel.firstAirDate = tvShow.firstAirDate
                tvShowModel.posterPath = tvShow.posterPath
                tvShowModel.type = 0
                localTvShowList.append(tvShowModel)
            })
            
            return localTvShowList
        }
    }
}
