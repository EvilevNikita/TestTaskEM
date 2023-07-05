//
//  CategoryViewModel.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 2/7/23.
//

import Combine
import Foundation

class CategoryViewModel: ObservableObject {
    @Published var categories = [Category]()
    @Published var selectedCategory: Category?

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadCategories()
    }

    func loadCategories() {
        guard let url = URL(string: "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54") else {
            print("Invalid Category URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: CategoryResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Network error: \(error.localizedDescription)")
                    }
                },
                receiveValue: { categoryResponse in
                    self.categories = categoryResponse.сategories
                }
            )
            .store(in: &cancellables)
    }
}
