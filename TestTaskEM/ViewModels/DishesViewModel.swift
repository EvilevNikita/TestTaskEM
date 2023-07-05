//
//  DishesViewModel.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 2/7/23.
//

import Combine
import Foundation

class DishesViewModel: ObservableObject {
    @Published var dishes = [Dish]()
    @Published var tags = ["Все меню", "Салаты", "С рисом", "С рыбой"]
    @Published var selectedTag: String = "Все меню"

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadDishes()
    }

    func loadDishes() {
        guard let url = URL(string: "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b") else {
            print("Invalid Dishes URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: DishesResponse.self, decoder: JSONDecoder())
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
                receiveValue: { dishesResponse in
                    self.dishes = dishesResponse.dishes
                }
            )
            .store(in: &cancellables)
    }
}
