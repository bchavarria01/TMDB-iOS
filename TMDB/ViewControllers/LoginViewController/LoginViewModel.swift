//
//  LoginViewModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

import RxSwift
import RxCocoa

final class LoginViewModel {
    
    // MARK: - Inputs
    
    let username = BehaviorRelay<String?>(value: nil)
    let password = BehaviorRelay<String?>(value: nil)
    
    // MARK: - Services
    
    private let authService: AuthService
    
    // MARK: - LifeCycle
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    // MARK: - Methods
    
    func getToken() -> Single<DefaultResponseModel> {
        return authService.getToken().map { (responseModel) -> DefaultResponseModel in
            DefaultPreferences.current.requestToken = responseModel.requestToken
            return responseModel
        }
    }
    
    func authenticateWithCredentials() -> Single<DefaultResponseModel> {
        guard let username = username.value
            else {
                return Single.error(LoginRequestException.username)
        }
        
        guard let password = password.value
            else {
                return Single.error(LoginRequestException.password)
        }
        
        let loginRequestModel = LoginRequestModel(username: username, password: password)
        
        if let validationExeption = loginRequestModel.localizeError() {
            return Single.error(validationExeption)
        }
        
        return authService.authenticateWithLogin(with: loginRequestModel)
            .map { (responseModel) -> DefaultResponseModel in
                DefaultPreferences.current.requestToken = responseModel.requestToken
                return responseModel
            }
    }
    
}
