//
//  DetailViewModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

import RxSwift
import CoreData

final class DetailViewModel {
    
    // MARK: - Services
    
    private let tvShowService: TvShowsService
    private let accountService: AccountService
    
    // MARK: - Attributes
    
    var context: NSManagedObjectContext!
    var isTest: Bool
    
    // MARK: - LifeCycle
    
    init(tvShowService: TvShowsService,
         accountService: AccountService,
         context: NSManagedObjectContext,
         isTest: Bool) {
        self.tvShowService = tvShowService
        self.accountService = accountService
        self.context = context
        self.isTest = isTest
    }
    
    // MARK: - Methods
    
    func markAsFav(tvId: Int, with flag: Bool) -> Single<DefaultResponseModel> {
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
        var userId: String?
        var sessionId: String?
        if localUserInfo.count > 0 {
            userId = localUserInfo[0].userId ?? ""
            sessionId = localSessions[0].sessionId ?? ""
        }
        return accountService.markAsFavorite(with: tvId, and: flag, userId: userId ?? "", and: sessionId ?? "")
    }
    
    func getAccountStats(from tvId: Int) -> Single<AccountStatesResponseModel> {
        var localSessions: [Session] = []
        let request = Session.fetchRequest() as NSFetchRequest<Session>
        do {
            localSessions = isTest ? [] : try self.context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        var sessionId: String?
        if localSessions.count > 0 {
            sessionId = localSessions[0].sessionId ?? ""
        }
        return tvShowService.getAccountStats(from: tvId, and: sessionId ?? "")
    }
    
    func getTvShowDetail(with tvId: Int) -> Single<TvShowsDetailModel> {
        return tvShowService.getTvShowDetail(with: tvId).map { detail in
            
            var localDetail: [TvShowDetail] = []
            let request = TvShowDetail.fetchRequest() as NSFetchRequest<TvShowDetail>
            let predicate = NSPredicate(format: "tvShowId == '\(detail.id ?? 0)'")
            request.predicate = predicate
            do {
                localDetail = self.isTest ? [] : try self.context.fetch(request)
            } catch {
                print(error.localizedDescription)
            }
            
            if localDetail.count > 0 {
                // If exists, them update
                
                // Update
                let tvShowDataModel = localDetail[0]
                var creators: [String] = []
                detail.createdBy?.forEach({ creator in
                    creators.append(creator.name ?? "")
                })
                let creatorsString = creators.joined(separator: ", ")
                tvShowDataModel.createdBy = "\(L10n.createdBy)\(creatorsString)"
                tvShowDataModel.tvShowId = detail.id as NSNumber?
                tvShowDataModel.lastSeasonName = detail.seasons?.last?.name
                tvShowDataModel.lastSeasonReleaseDate = detail.seasons?.last?.airDate
                tvShowDataModel.tvShowDetailDescription = detail.overview
                tvShowDataModel.tvShowDetailName = detail.name
                tvShowDataModel.tvShowDetailRate = Float(detail.voteAverage ?? 0)
                tvShowDataModel.numberOfSeasons = Int16(detail.numberOfSeasons ?? 0)
                
                let detailImageUrl = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(detail.posterPath ?? "")")!
                let lastSeasonImageUrl = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(detail.seasons?.last?.posterPath ?? "")")!
                do {
                    let detailImageData = try Data(contentsOf: detailImageUrl)
                    tvShowDataModel.tvShowDetailImage = detailImageData
                    
                    let lastSeasonImageData = try Data(contentsOf: lastSeasonImageUrl)
                    tvShowDataModel.lastSeasonImage = lastSeasonImageData
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                // If not them create
                
                // Create data model
                let tvShowDetailDataModel = TvShowDetail(context: self.context)
                var creators: [String] = []
                detail.createdBy?.forEach({ creator in
                    creators.append(creator.name ?? "")
                })
                let creatorsString = creators.joined(separator: ", ")
                tvShowDetailDataModel.createdBy = "\(L10n.createdBy)\(creatorsString)"
                tvShowDetailDataModel.tvShowId = detail.id as NSNumber?
                tvShowDetailDataModel.lastSeasonName = detail.seasons?.last?.name
                tvShowDetailDataModel.lastSeasonReleaseDate = detail.seasons?.last?.airDate
                tvShowDetailDataModel.tvShowDetailDescription = detail.overview
                tvShowDetailDataModel.tvShowDetailName = detail.name
                tvShowDetailDataModel.tvShowDetailRate = Float(detail.voteAverage ?? 0)
                tvShowDetailDataModel.numberOfSeasons = Int16(detail.numberOfSeasons ?? 0)
                
                let detailImageUrl = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(detail.posterPath ?? "")")!
                let lastSeasonImageUrl = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(detail.seasons?.last?.posterPath ?? "")")!
                do {
                    let detailImageData = try Data(contentsOf: detailImageUrl)
                    tvShowDetailDataModel.tvShowDetailImage = detailImageData
                    
                    let lastSeasonImageData = try Data(contentsOf: lastSeasonImageUrl)
                    tvShowDetailDataModel.lastSeasonImage = lastSeasonImageData
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            do {
                try self.context.save()
            } catch {
                print(error.localizedDescription)
            }
            
            // Map to custom model
            
            let model = TvShowsDetailModel()
            model.backdropPath = detail.backdropPath
            var creators: [String] = []
            detail.createdBy?.forEach({ creator in
                creators.append(creator.name ?? "")
            })
            let creatorsString = creators.joined(separator: ", ")
            model.createdBy = creatorsString
            model.id = detail.id
            model.name = detail.name
            model.numberOfEpisodes = detail.numberOfEpisodes
            model.numberOfSeasons = detail.numberOfSeasons
            model.overview = detail.overview
            model.posterPath = detail.posterPath
            model.status = detail.status
            model.type = detail.type
            model.voteAverage = detail.voteAverage
            model.lastSeasonImagePath = detail.seasons?.last?.posterPath
            model.lastSeasonName = detail.seasons?.last?.name
            model.lastSeasonReleaseDate = detail.seasons?.last?.airDate
            
            return model
        }
    }
    
    func getLocalTvShowDetail(with tvId: Int) -> Single<TvShowsDetailModel> {
        var detail: [TvShowDetail] = []
        let request = TvShowDetail.fetchRequest() as NSFetchRequest<TvShowDetail>
        let predicate = NSPredicate(format: "tvShowId == '\(tvId)'")
        request.predicate = predicate
        do {
            detail = self.isTest ? [] : try self.context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        let model = TvShowsDetailModel()
        model.backdropPath = ""
        model.createdBy = detail.first?.createdBy
        model.id = detail.first?.tvShowId as? Int
        model.name = detail.first?.tvShowDetailName
        model.numberOfSeasons = Int(detail.first?.numberOfSeasons ?? 0)
        model.overview = detail.first?.tvShowDetailDescription
        model.posterPath = ""
        model.type = ""
        model.detailImageData = detail.first?.tvShowDetailImage
        model.lastSeasonImageData = detail.first?.lastSeasonImage
        model.lastSeasonName = detail.first?.lastSeasonName
        model.lastSeasonReleaseDate = detail.first?.lastSeasonReleaseDate
        model.lastSeasonImagePath = ""
        model.voteAverage = Double(detail.first?.tvShowDetailRate ?? 0)
        
        return Observable.from(optional: model).asSingle()
    }
    
    func getCast(with tvId: Int) -> Single<[CustomCast]> {
        return tvShowService.getCredits(with: tvId).map { castResponse in
            var modelList: [CustomCast] = []
            castResponse.cast?.forEach { cast in
                var localCast: [TvShowCast] = []
                let request = TvShowCast.fetchRequest() as NSFetchRequest<TvShowCast>
                let predicate = NSPredicate(format: "castName == '\(cast.name ?? "")'")
                request.predicate = predicate
                do {
                    localCast = self.isTest ? [] : try self.context.fetch(request)
                } catch {
                    print(error.localizedDescription)
                }
                if localCast.count > 0 {
                    let tvShowCastDataModel: TvShowCast = localCast[0]
                    tvShowCastDataModel.tvShowId = tvId as NSNumber?
                    tvShowCastDataModel.castName = cast.name
                    let castImageUrl = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(cast.profilePath ?? "")")!
                    do {
                        let castImageData = try Data(contentsOf: castImageUrl)
                        tvShowCastDataModel.castImage = castImageData
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    let tvShowCastDataModel = TvShowCast(context: self.context)
                    tvShowCastDataModel.tvShowId = tvId as NSNumber?
                    tvShowCastDataModel.castName = cast.name
                    let castImageUrl = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(cast.profilePath ?? "")")!
                    do {
                        let castImageData = try Data(contentsOf: castImageUrl)
                        tvShowCastDataModel.castImage = castImageData
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
                do {
                    try self.context.save()
                } catch {
                    print(error.localizedDescription)
                }
                
                var model = CustomCast()
                
                model.imagePath = cast.profilePath
                model.name = cast.name
                
                modelList.append(model)
            }
            return modelList
        }
    }
    
    func getLocalCast(with tvId: Int) -> Single<[CustomCast]> {
        var modelList: [CustomCast] = []
        
        var localCast: [TvShowCast] = []
        let request = TvShowCast.fetchRequest() as NSFetchRequest<TvShowCast>
        let predicate = NSPredicate(format: "tvShowId == '\(tvId)'")
        request.predicate = predicate
        do {
            localCast = self.isTest ? [] : try self.context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        localCast.forEach { cast in
            var model = CustomCast()
            model.name = cast.castName
            model.imageData = cast.castImage
            model.imagePath = ""
            
            modelList.append(model)
        }
        
        return Observable.from(optional: modelList).asSingle()
    }
}
