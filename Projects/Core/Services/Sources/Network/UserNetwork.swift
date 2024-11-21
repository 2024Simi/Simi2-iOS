//
//  UserNetwork.swift
//  Services
//
//  Created by 박서연 on 2024/10/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation
import Models
import Common
import Combine

protocol UserNetworkInterface {
    func getUser() -> AnyPublisher<UserDTO, NetworkError>
    func patchNickname() -> AnyPublisher<Data, NetworkError>
    func patchPrivatePolicy() -> AnyPublisher<Data, NetworkError>
}

//public class AuthNetwork: ApiService, DiaryNetworkInterface {}
