//
//  PromptNetwork.swift
//  Services
//
//  Created by 박서연 on 2024/10/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Common
import Combine
import Models
import Foundation

protocol PromptNetworkInterface {
    func postPrompt() -> AnyPublisher<Data, NetworkError>
    func postPromptCompletions() -> AnyPublisher<Data, NetworkError>
}

//public class PromptNetwork: ApiService, DiaryNetworkInterface {}
