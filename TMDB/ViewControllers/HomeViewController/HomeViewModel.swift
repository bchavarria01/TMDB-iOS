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
    
    // MARK: - Services
    
    private let tvShowService: TvShowsService
    
    // MARK: - LifeCycle
    
    init(tvShowService: TvShowsService,
         context: NSManagedObjectContext) {
        self.tvShowService = tvShowService
        self.context = context
        
        tvShowList = Observable.combineLatest(
            type.startWith(.popular),
            page.startWith(1)
        ).flatMapLatest{ type, page -> Observable<[TvShowsModel]> in
            return tvShowService.getTvShows(with: page ?? 1, and: type).map {
                var tvShowModelList: [TvShowsModel] = []
                $0.results?.forEach({ tvShow in
                    var localTvShowList: [Show] = []
                    let request = Show.fetchRequest() as NSFetchRequest<Show>
                    let predicate = NSPredicate(format: "tvShowId == '\(tvShow.id ?? 0)'")
                    request.predicate = predicate
                    do {
                         localTvShowList = try context.fetch(request)
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
                        let tvShowDataModel = Show(context: context)
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
            var localTvShowList: [Show] = []
            let request = Show.fetchRequest() as NSFetchRequest<Show>
            let predicate = NSPredicate(format: "type == '\(type.rawValue)'")
            request.predicate = predicate
            do {
                 localTvShowList = try context.fetch(request)
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
    
    func deleteSession() {
        var localSessions: [Session] = []
        let request = Session.fetchRequest() as NSFetchRequest<Session>
        do {
            localSessions = try self.context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        let sessionToDelete = localSessions[0]
        self.context.delete(sessionToDelete)
        
        do {
            try self.context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

}
