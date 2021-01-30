//
//  AccountService.swift
//  TMDB
//
//  Created by Byron Chavarría on 4/1/21.
//

import Moya
import RxSwift

final class AccountService {
    private let provider = MoyaProvider<AccountProvider>(
        plugins: K.MoyaDefaults.plugins
    )
    
    func getAccountInfo(with sessionId: String) -> Single<AccountResponseModel> {
        return provider.rx.request(.getAccountDetail(sessionId: sessionId))
            .filterSuccessfulStatusCodes()
            .map(AccountResponseModel.self)
            .asObservable()
            .asSingle()
    }
    
    func getFavortitesTvShows(with userId: String, and sessionId: String) -> Single<DefaultListResponseModel> {
        return provider.rx.request(.getFavoritesTvShows(userId: userId, sessionId: sessionId))
            .filterSuccessfulStatusCodes()
            .map(DefaultListResponseModel.self)
            .asObservable()
            .asSingle()
    }
    
    func markAsFavorite(with tvId: Int, and flag: Bool, userId: String, and sessionId: String) -> Single<DefaultResponseModel> {
        return provider.rx.request(.markAsFav(tvId: tvId, flag: flag, userId: userId, sessionId: sessionId))
            .filterSuccessfulStatusCodes()
            .map(DefaultResponseModel.self)
            .asObservable()
            .asSingle()
    }
}
