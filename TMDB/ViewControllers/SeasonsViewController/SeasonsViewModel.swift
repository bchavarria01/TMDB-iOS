//
//  SeasonsViewModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 31/12/20.
//

import RxSwift
import RxCocoa
import CoreData

final class SeasonsViewModel {
    
    // MARK: - Inputs
    
    let tvId = PublishSubject<Int>()
    let seasonId = PublishSubject<Int?>()
    
    let tvShowId = BehaviorRelay<Int?>(value: nil)
    
    // MARK: - Outputs
    
    let seasonsList: Observable<EpisodesModel?>
    let localseasonsList: Observable<EpisodesModel?>
    
    // MARK: - Services
    
    private let tvShowService: TvShowsService
    
    // MARK: - Attributes
    
    let context: NSManagedObjectContext!
    
    // MARK: - LifeCycle
    
    init(tvShowService: TvShowsService,
         context: NSManagedObjectContext) {
        self.tvShowService = tvShowService
        self.context = context
        
        seasonsList = Observable.combineLatest(
            tvId,
            seasonId.startWith(1)
        ).flatMapLatest{ tvId, seasonId -> Observable<EpisodesModel?> in
            return tvShowService.getSeasonInfo(with: tvId, and: seasonId ?? 0).map { seasonInfo in
                
                var customEpisodeList: [CustomEpisode] = []
                
                seasonInfo.episodes?.forEach { episode in
                    var localSeasonInfo: [TvShowEpisodePerSeason] = []
                    let request = TvShowEpisodePerSeason.fetchRequest() as NSFetchRequest<TvShowEpisodePerSeason>
                    let predicate = NSPredicate(format: "episodeId == '\(episode.id ?? 0)'")
                    request.predicate = predicate
                    do {
                         localSeasonInfo = try context.fetch(request)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    if localSeasonInfo.count > 0 {
                        let seasonToUpdate = localSeasonInfo[0]
                        seasonToUpdate.episodeId = Int32(episode.id ?? 0)
                        seasonToUpdate.seasonName = "Season \(seasonId ?? 0)"
                        seasonToUpdate.tvShowId = tvId as NSNumber?
                        seasonToUpdate.episodeName = episode.name
                        let url = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(episode.stillPath ?? "")")!
                        do {
                            let imageData = try Data(contentsOf: url)
                            seasonToUpdate.episodeImage = imageData
                        } catch {
                            print(error.localizedDescription)
                        }
                    } else {
                        let seasonToCreate = TvShowEpisodePerSeason(context: context)
                        seasonToCreate.episodeId = Int32(episode.id ?? 0)
                        seasonToCreate.seasonName = "Season \(seasonId ?? 0)"
                        seasonToCreate.tvShowId = tvId as NSNumber?
                        seasonToCreate.episodeName = episode.name
                        let url = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(episode.stillPath ?? "")")!
                        do {
                            let imageData = try Data(contentsOf: url)
                            seasonToCreate.episodeImage = imageData
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                    // Saving data
                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    var currentEpisode = CustomEpisode()
                    currentEpisode.episodeName = episode.name
                    currentEpisode.episodePath = episode.stillPath
                    
                    customEpisodeList.append(currentEpisode)
                }
                let episodeModel: EpisodesModel? = EpisodesModel(seasonName: "Season \(seasonId ?? 0)", episodes: customEpisodeList)
                return episodeModel
            }
        }
        
        localseasonsList = Observable.combineLatest(
            tvId,
            seasonId.startWith(1)
        ).flatMapLatest{ tvId, seasonId -> Observable<EpisodesModel?> in
            return tvShowService.getSeasonInfo(with: tvId, and: seasonId ?? 0).map { seasonInfo in
                
                var customEpisodeList: [CustomEpisode] = []
                
                var localSeasonInfo: [TvShowEpisodePerSeason] = []
                let request = TvShowEpisodePerSeason.fetchRequest() as NSFetchRequest<TvShowEpisodePerSeason>
                let predicate = NSPredicate(format: "tvShowId == '\(tvId)' AND seasonName == 'Season \(seasonId ?? 0)'")
                request.predicate = predicate
                do {
                     localSeasonInfo = try context.fetch(request)
                } catch {
                    print(error.localizedDescription)
                }
                
                if localSeasonInfo.count > 0 {
                    localSeasonInfo.forEach { episode in
                        var currentEpisode = CustomEpisode()
                        currentEpisode.episodeName = episode.episodeName
                        currentEpisode.episodePath = ""
                        currentEpisode.episodeImage = episode.episodeImage
                        
                        customEpisodeList.append(currentEpisode)
                    }
                }
                let episodeModel: EpisodesModel? = EpisodesModel(seasonName: "Season \(seasonId ?? 0)", episodes: customEpisodeList)
                return episodeModel
            }
        }
    }
}
