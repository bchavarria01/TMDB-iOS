//
//  AuthService.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

import Moya
import RxSwift

final class AuthService {
    
    private let provider = MoyaProvider<AuthenticationProvider>(
        plugins: K.MoyaDefaults.plugins
    )
    
    func getToken() -> Single<DefaultResponseModel> {
        return provider.rx.request(.getToken)
            .filterSuccessfulStatusCodes()
            .map(DefaultResponseModel.self)
            .asObservable()
            .asSingle()
    }
    
    func authenticateWithLogin(with request: LoginRequestModel) -> Single<DefaultResponseModel> {
        return provider.rx.request(.authenticateWithLogin(request: request))
            .map(DefaultResponseModel.self)
            .asObservable()
            .asSingle()
    }
}
