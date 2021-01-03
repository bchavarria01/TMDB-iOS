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
    
    let tvShowService: TvShowsService
    
    // MARK: - Attributes
    
    var context: NSManagedObjectContext!
    
    // MARK: - LifeCycle
    
    init(tvShowService: TvShowsService,
         context: NSManagedObjectContext) {
        self.tvShowService = tvShowService
        self.context = context
    }
    
    // MARK: - Methods
    
    func getTvShowDetail(with tvId: Int) -> Single<TvShowsDetailModel> {
        return tvShowService.getTvShowDetail(with: tvId).map { detail in
            
            var localDetail: [TvShowDetail] = []
            let request = TvShowDetail.fetchRequest() as NSFetchRequest<TvShowDetail>
            let predicate = NSPredicate(format: "tvShowId == '\(detail.id ?? 0)'")
            request.predicate = predicate
            do {
                localDetail = try self.context.fetch(request)
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
            detail = try self.context.fetch(request)
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
                    localCast = try self.context.fetch(request)
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
            localCast = try self.context.fetch(request)
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
