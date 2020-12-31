//
//  DetailViewModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

import RxSwift

final class DetailViewModel {
    
    // MARK: - Services
    
    let tvShowService: TvShowsService
    
    // MARK: - LifeCycle
    
    init(tvShowService: TvShowsService) {
        self.tvShowService = tvShowService
    }
    
    // MARK: - Methods
    
    func getTvShowDetail(with tvId: Int) -> Single<DetailsTvShowResponseModel> {
        return tvShowService.getTvShowDetail(with: tvId)
    }
    
    func getCast(with tvId: Int) -> Single<CastResponseModel> {
        return tvShowService.getCredits(with: tvId)
    }
}
