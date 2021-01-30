//
//  HomeViewModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

import RxSwift
import RxCocoa
import CoreData

final class HomeViewModel {
    
    // MARK: - Inputs
    
    let type = PublishSubject<TvShowsFilterType>()
    let page = PublishSubject<Int?>()
    
    // MARK: - Outputs
    
    let tvShowList: Observable<[TvShowsModel]>
    let localTvShowsList: Observable<[TvShowsModel]>
    
    // MARK: - Attributes
    
    var context: NSManagedObjectContext!
    var isTest: Bool
    
    // MARK: - Services
    
    private let tvShowService: TvShowsService
    private let authService: AuthService
    private let accountService: AccountService
    
    // MARK: - LifeCycle
    
    init(tvShowService: TvShowsService,
         authService: AuthService,
         accountService: AccountService,
         context: NSManagedObjectContext,
         isTest: Bool) {
        self.tvShowService = tvShowService
        self.authService = authService
        self.accountService = accountService
        self.context = context
        self.isTest = isTest
        
        tvShowList = Observable.combineLatest(
            type.startWith(.popular),
            page.startWith(1)
        ).flatMapLatest{ type, page -> Observable<[TvShowsModel]> in
            return tvShowService.getTvShows(with: page ?? 1, and: type).map {
                var tvShowModelList: [TvShowsModel] = []
                $0.results?.forEach({ tvShow in
                    var localTvShowList: [TvShowList] = []
                    let request = TvShowList.fetchRequest() as NSFetchRequest<TvShowList>
                    let predicate = NSPredicate(format: "tvShowId == '\(tvShow.id ?? 0)'")
                    request.predicate = predicate
                    do {
                        localTvShowList = isTest ? [] : try context.fetch(request)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    if localTvShowList.count > 0 {
                        // If exists, them update
                        
                        // Update
                        let tvShowDataModel = localTvShowList[0]
                        tvShowDataModel.tvShowId = tvShow.id as NSNumber?
                        tvShowDataModel.tvShowName = tvShow.name
                        tvShowDataModel.tvShowDescription = tvShow.overview
                        tvShowDataModel.tvShowRate = Float(tvShow.voteAverage ?? 0)
                        tvShowDataModel.tvShowReleaseDate = tvShow.firstAirDate
                        tvShowDataModel.type = Int32(type.rawValue)
                        
                        let url = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(tvShow.posterPath ?? "")")!
                        do {
                            let imageData = try Data(contentsOf: url)
                            tvShowDataModel.tvShowImage = imageData
                        } catch {
                            print(error.localizedDescription)
                        }
                    } else {
                        // If not them create
                        
                        // Create data model
                        let tvShowDataModel = TvShowList(context: context)
                        tvShowDataModel.tvShowId = tvShow.id as NSNumber?
                        tvShowDataModel.tvShowName = tvShow.name
                        tvShowDataModel.tvShowDescription = tvShow.overview
                        tvShowDataModel.tvShowRate = Float(tvShow.voteAverage ?? 0)
                        tvShowDataModel.tvShowReleaseDate = tvShow.firstAirDate
                        tvShowDataModel.type = Int32(type.rawValue)
                        
                        let url = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(tvShow.posterPath ?? "")")!
                        do {
                            let imageData = try Data(contentsOf: url)
                            tvShowDataModel.tvShowImage = imageData
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                    let tvShowModel = TvShowsModel()
                    tvShowModel.id = tvShow.id
                    tvShowModel.name = tvShow.name
                    tvShowModel.overview = tvShow.overview
                    tvShowModel.voteAverage = tvShow.voteAverage
                    tvShowModel.firstAirDate = tvShow.firstAirDate
                    tvShowModel.type = type.rawValue
                    tvShowModel.posterPath = tvShow.posterPath
                    
                    tvShowModelList.append(tvShowModel)
                    
                    // Saving data
                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                })
                return tvShowModelList
            }
        }
        
        localTvShowsList = Observable.combineLatest(
            type.startWith(.popular),
            page.startWith(1)
        ).flatMapLatest{ type, page -> Observable<[TvShowsModel]> in
            var localTvShowList: [TvShowList] = []
            let request = TvShowList.fetchRequest() as NSFetchRequest<TvShowList>
            let predicate = NSPredicate(format: "type == '\(type.rawValue)'")
            request.predicate = predicate
            do {
                localTvShowList = isTest ? [] : try context.fetch(request)
            } catch {
                print(error.localizedDescription)
            }
            var tvShowList: [TvShowsModel] = []
            localTvShowList.forEach { localTvShow in
                let model = TvShowsModel()
                model.id = localTvShow.tvShowId as? Int
                model.name = localTvShow.tvShowName
                model.overview = localTvShow.tvShowDescription
                model.voteAverage = Double(localTvShow.tvShowRate)
                model.firstAirDate = localTvShow.tvShowReleaseDate
                model.type = type.rawValue
                model.posterPath = ""
                model.imageData = localTvShow.tvShowImage
                tvShowList.append(model)
            }
            return Observable.from(optional: tvShowList)
        }
    }
    
    func createNewSession() -> Single<DefaultModel> {
        var localSessions: [Session] = []
        var localUserInfo: [UserInfo] = []
        
        let request = Session.fetchRequest() as NSFetchRequest<Session>
        let request2 = UserInfo.fetchRequest() as NSFetchRequest<UserInfo>
        do {
            localSessions = isTest ? [] : try self.context.fetch(request)
            localUserInfo = isTest ? [] : try self.context.fetch(request2)
        } catch {
            print(error.localizedDescription)
        }

        if localUserInfo.count > 0 {
            // If exists, return them
            let session = localSessions[0]
            let responseModel = DefaultModel()
            responseModel.expiresAt = session.expDate
            responseModel.requestToken = session.token
            responseModel.sessionId = session.sessionId
            return Observable.from([responseModel]).asSingle()
        } else {
            var token = ""
            if localSessions.count > 0 {
                token = localSessions[0].token ?? ""
            }
            return authService.createNewSession(with: token).map { response in
                var localSessions: [Session] = []
                let request = Session.fetchRequest() as NSFetchRequest<Session>
                do {
                    localSessions = self.isTest ? [] : try self.context.fetch(request)
                } catch {
                    print(error.localizedDescription)
                }
                if localSessions.count > 0 {
                    let tokenModel = localSessions[0]
                    tokenModel.sessionId = response.sessionId
                    
                    do {
                        try self.context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
                let responseModel = DefaultModel()
                responseModel.expiresAt = response.expiresAt
                responseModel.requestToken = response.requestToken
                responseModel.sessionId = response.sessionId
                return responseModel
            }
        }
    }
    
    func getAccountInfo() -> Single<AccountModel> {
        var localSessions: [Session] = []
        var localUserInfo: [UserInfo] = []
        let request = Session.fetchRequest() as NSFetchRequest<Session>
        let request2 = UserInfo.fetchRequest() as NSFetchRequest<UserInfo>
        do {
            localSessions = try isTest ? [] : self.context.fetch(request)
            localUserInfo = try isTest ? [] : self.context.fetch(request2)
        } catch {
            print(error.localizedDescription)
        }
        if localUserInfo.count > 0 {
            // If exists, return them
            let userInfo = localUserInfo[0]
            let responseModel = AccountModel()
            responseModel.imageData = userInfo.imageData
            responseModel.imagePath = userInfo.imagePath
            responseModel.userId = userInfo.userId
            responseModel.username = userInfo.username
            return Observable.from([responseModel]).asSingle()
            
        } else {
            // If not them ask for
            var session: Session = Session()
            if localSessions.count > 0 {
                session = localSessions[0]
            }
            return accountService.getAccountInfo(with: session.sessionId ?? "").map {
                let userinfoModel = UserInfo(context: self.context)
                let responseModel = AccountModel()
                
                let url = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\($0.avatar?.tmdb?.avatarPath ?? "")")!
                do {
                    let imageData = try Data(contentsOf: url)
                    userinfoModel.imageData = imageData
                    responseModel.imageData = imageData
                } catch {
                    print(error.localizedDescription)
                }
                
                userinfoModel.imagePath = $0.avatar?.tmdb?.avatarPath
                userinfoModel.userId = String($0.id ?? 0)
                userinfoModel.username = $0.username
                
                responseModel.imagePath = $0.avatar?.tmdb?.avatarPath
                responseModel.userId = String($0.id ?? 0)
                responseModel.username = $0.username
                
                do {
                    try self.context.save()
                } catch {
                    print(error.localizedDescription)
                }
                
                return responseModel
            }
        }
    }
    
    func deleteSession() {
        var localSessions: [Session] = []
        var localUserInfo: [UserInfo] = []
        let request = Session.fetchRequest() as NSFetchRequest<Session>
        let request2 = UserInfo.fetchRequest() as NSFetchRequest<UserInfo>
        do {
            localSessions = isTest ? [] : try self.context.fetch(request)
            localUserInfo = isTest ? [] : try self.context.fetch(request2)
        } catch {
            print(error.localizedDescription)
        }
        
        if localSessions.count > 0 {
            let sessionToDelete = localSessions[0]
            self.context.delete(sessionToDelete)
            
            do {
                try self.context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        if localUserInfo.count > 0 {
            let userToDelete = localUserInfo[0]
            self.context.delete(userToDelete)
            
            do {
                try self.context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
