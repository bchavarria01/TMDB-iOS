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
    
    func getTvShowDetail(with tvId: Int) -> Single<DetailsTvShowResponseModel> {
        return tvShowService.getTvShowDetail(with: tvId)
    }
    
    func getLocalTvShowDetail() {
        
    }
    
    func getCast(with tvId: Int) -> Single<CastResponseModel> {
        return tvShowService.getCredits(with: tvId)
    }
}
