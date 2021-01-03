//
//  LoginViewModel.swift
//  TMDB
//
//  Created by Byron Chavarría on 30/12/20.
//

import RxSwift
import RxCocoa
import CoreData

final class LoginViewModel {
    
    // MARK: - Inputs
    
    let username = BehaviorRelay<String?>(value: nil)
    let password = BehaviorRelay<String?>(value: nil)
    
    // MARK: - Services
    
    private let authService: AuthService
    
    // MARK: - Attributes

    var context: NSManagedObjectContext!
    
    // MARK: - LifeCycle
    
    init(authService: AuthService,
         context: NSManagedObjectContext) {
        self.authService = authService
        self.context = context
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
                
                // Delete every time user request a new token
                self.deleteSession()
                // Create a new session locally
                self.createNewSession(with: responseModel)
                
                return responseModel
            }
    }
    
    func createNewSession(with responseModel: DefaultResponseModel) {
        let tokenModel = Session(context: self.context)
        tokenModel.expDate = responseModel.expiresAt
        tokenModel.token = responseModel.requestToken
        
        do {
            try self.context.save()
        } catch {
            print(error.localizedDescription)
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
        
        if localSessions.count > 0 {
            let sessionToDelete = localSessions[0]
            self.context.delete(sessionToDelete)
    //
            do {
                try self.context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
