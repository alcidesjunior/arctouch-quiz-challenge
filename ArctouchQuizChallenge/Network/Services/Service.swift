//
//  Service.swift
//  ArctouchQuizChallenge
//
//  Created by Alcides Junior on 13/01/20.
//  Copyright © 2020 Alcides Junior. All rights reserved.
//

import Foundation

enum Service: ServiceProtocol{
    
    case quiz
    
    var baseURL: URL{
        return URL(string: "https://codechallenge.arctouch.com/")!
    }
    
    var path: String{
        switch self {
        case .quiz:
            return "quiz/1"
        }
    }
    
    var method: HTTPMethod{
        return .get
    }
    
    var task: Task{
        switch self {
        case .quiz:
            return .requestPlain
        }
    }
    
    var headers: Headers?{
        return nil
    }
    
    var parametersEncoding: ParametersEncoding{
        return .url
    }
    
    
}
