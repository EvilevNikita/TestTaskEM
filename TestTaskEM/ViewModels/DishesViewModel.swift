//
//  DishesViewModel.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 2/7/23.
//

import Foundation

class DishesViewModel: ObservableObject {
    @Published var dishes = [Dish]()
    @Published var tags = ["Все меню", "Салаты", "С рисом", "С рыбой"]
    @Published var selectedTag: String = "Все меню"

    init() {
        loadDishes()
    }

    func loadDishes() {
        guard let url = URL(string: "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b") else {
            print("Invalid Dishes URL")
            return
        }

        NetworkManager.shared.fetchData(from: url) { (result: Result<DishesResponse, Error>) in
            switch result {
            case .success(let dishesResponse):
                DispatchQueue.main.async {
                    self.dishes = dishesResponse.dishes
                }
            case .failure(let error):
                print("Failed to decode JSON: \(error)")
            }
        }
    }
}
