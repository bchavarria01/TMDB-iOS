//
//  HomeViewModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

import RxSwift
import RxCocoa

final class HomeViewModel {
    
    // MARK: - Inputs
    
    let type = PublishSubject<TvShowsFilterType>()
    let page = PublishSubject<Int?>()
    
    // MARK: - Outputs
    
    let tvShowList: Observable<DefaultListResponseModel>
    
    // MARK: - Services
    
    private let tvShowService: TvShowsService
    
    // MARK: - LifeCycle
    
    init(tvShowService: TvShowsService) {
        self.tvShowService = tvShowService
        
        tvShowList = Observable.combineLatest(
            type.startWith(.popular),
            page.startWith(1)
        ).flatMapLatest{ type, page -> Observable<DefaultListResponseModel> in
            return tvShowService.getTvShows(with: page ?? 1, and: type)
        }
    }
}
