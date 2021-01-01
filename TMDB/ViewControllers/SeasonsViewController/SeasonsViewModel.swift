//
//  SeasonsViewModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 31/12/20.
//

import RxSwift
import RxCocoa

final class SeasonsViewModel {
    
    // MARK: - Inputs
    
    let tvId = PublishSubject<Int>()
    let seasonId = PublishSubject<Int?>()
    
    let tvShowId = BehaviorRelay<Int?>(value: nil)
    
    // MARK: - Outputs
    
    let seasonsList: Observable<EpisodesModel?>
    
    // MARK: - Services
    
    private let tvShowService: TvShowsService
    
    // MARK: - LifeCycle
    
    init(tvShowService: TvShowsService) {
        self.tvShowService = tvShowService
        
        seasonsList = Observable.combineLatest(
            tvId,
            seasonId.startWith(1)
        ).flatMapLatest{ tvId, seasonId -> Observable<EpisodesModel?> in
            return tvShowService.getSeasonInfo(with: tvId, and: seasonId ?? 0).map {
                let episodeModel: EpisodesModel? = EpisodesModel(seasonName: "Season \(seasonId ?? 0)", episodes: $0.episodes)
                return episodeModel
            }
        }
    }
}
