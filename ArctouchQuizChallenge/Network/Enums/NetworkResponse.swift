//
//  NetworkResponse.swift
//  ArctouchQuizChallenge
//
//  Created by Alcides Junior on 13/01/20.
//  Copyright © 2020 Alcides Junior. All rights reserved.
//

import Foundation

enum NetworkResponse<T>{
    case success(T)
    case failure(NetworkError)
}
