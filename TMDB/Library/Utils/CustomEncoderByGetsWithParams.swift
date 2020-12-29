//
//  CustomEncoderByGetsWithParams.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import Moya
import Alamofire

public struct CompositeEncoding: ParameterEncoding {

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        guard let parameters = parameters else {
            return try urlRequest.asURLRequest()
        }

        let queryParamters = (parameters["query"] as! Parameters)
        let bodyParameters = (parameters["body"] as! Parameters)

        let queryRequest = try URLEncoding(destination: .queryString).encode(urlRequest, with: queryParamters)
        let bodyRequest = try JSONEncoding().encode(urlRequest, with: bodyParameters)

        var compositeRequest = bodyRequest
        compositeRequest.url = queryRequest.url
        return compositeRequest
    }
}
