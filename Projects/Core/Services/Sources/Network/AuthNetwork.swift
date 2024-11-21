//
//  AuthNetwork.swift
//  Services
//
//  Created by 박서연 on 2024/10/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Common
import Models
import Combine
import Foundation

protocol AuthNetworkInterface {
    func postRefresh() -> AnyPublisher<PostAuthDTO, NetworkError>
    func postLogout() -> AnyPublisher<Data, NetworkError>
    func postLogin() -> AnyPublisher<PostAuthDTO, NetworkError>
    func postProvider(loginType: String, idToken: String) -> AnyPublisher<Data, NetworkError>
}

//public class AuthNetwork: ApiService, DiaryNetworkInterface {}
