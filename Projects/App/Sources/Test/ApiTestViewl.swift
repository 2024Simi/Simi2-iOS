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
import Network
import Models
import Common

class ApiTestViewModel: ObservableObject {
    @State var testData: Data = .init()
    private let diaryService = DiaryService(apiService: ApiService())
    @Published var diaryTest: [DiaryEntity] = []
    @Published var errorMessage: String? = nil
    private var cancellables = Set<AnyCancellable>()
    
    func testButtonTapped() {
        diaryService.getDiary(startDate: "2024-10-01", endDate: "2024-10-10")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("🔵 Diary Success!")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("🔴 Diary Failure! \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] diary in
                self?.diaryTest = diary
            }
            .store(in: &cancellables)
    }
}

struct ApiTestView: View {
    @StateObject private var viewModel = ApiTestViewModel()
    private let diaryNetwork = DiaryService(apiService: ApiService())
    
    var body: some View {
        VStack {
            Text("Test")
                .onTapGesture {
                    print("tapped~~ header \(masterAccessToken)")
                    viewModel.testButtonTapped()
                }
            ForEach(viewModel.diaryTest, id: \.id) { data in
                Text(data.primaryEmotion)
                Text(data.createdAt)
            }
        }
    }
}

#Preview {
    ApiTestView()
}
