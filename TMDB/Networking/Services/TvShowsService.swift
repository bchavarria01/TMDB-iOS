//
//  TvShowsService.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

import Moya
import RxSwift

final class TvShowsService {
    
    private let provider = MoyaProvider<TvShowsProvider>(
        plugins: K.MoyaDefaults.plugins
    )
    
    func getTvShows(with page: Int = 1, and filterType: TvShowsFilterType) -> Observable<DefaultListResponseModel> {
        switch filterType {
        case .airing:
            return provider.rx.request(.getAiring(page: page))
                .filterSuccessfulStatusCodes()
                .map(DefaultListResponseModel.self)
                .asObservable()
            
        case .onTv:
            return provider.rx.request(.getOnTv(page: page))
                .filterSuccessfulStatusCodes()
                .map(DefaultListResponseModel.self)
                .asObservable()
            
        case .popular:
            return provider.rx.request(.getPopular(page: page))
                .filterSuccessfulStatusCodes()
                .map(DefaultListResponseModel.self)
                .asObservable()
            
        case .topRated:
            return provider.rx.request(.getTopRated(page: page))
                .filterSuccessfulStatusCodes()
                .map(DefaultListResponseModel.self)
                .asObservable()
        }
    }
    
    func getTvShowDetail(with tvId: Int) -> Single<DetailsTvShowResponseModel> {
        return provider.rx.request(.getDetail(tvId: tvId))
            .filterSuccessfulStatusCodes()
            .map(DetailsTvShowResponseModel.self)
            .asObservable()
            .asSingle()
    }
    
    func getCredits(with tvId: Int) -> Single<CastResponseModel> {
        return provider.rx.request(.getCredits(tvId: tvId))
            .filterSuccessfulStatusCodes()
            .map(CastResponseModel.self)
            .asObservable()
            .asSingle()
    }
}
