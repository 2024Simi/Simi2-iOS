//
//  ApiTestViewModel.swift
//  App
//
//  Created by 박서연 on 2024/10/22.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import SwiftUI
import Services
import Combine

class ApiTestViewModel: ObservableObject {
    @State var testData: Data = .init()
    private let apiService = ApiService()
    private var cancellables = Set<AnyCancellable>()
    
    func testApi() {
        apiService.request(httpMethod: .get, endPoint: "")
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    debugPrint("error \(error.localizedDescription)")
                }
            } receiveValue: { data in
                print("data result \(data)")
            }
            .store(in: &cancellables)
    }
}

struct ApiTestView: View {
    @StateObject private var viewModel = ApiTestViewModel()
    
    var body: some View {
        Text("Test")
            .onTapGesture {
                viewModel.testApi()
            }
    }
}

#Preview {
    ApiTestView()
}
