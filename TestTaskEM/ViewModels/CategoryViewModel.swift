//
//  CategoryViewModel.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 2/7/23.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var categories = [Category]()
    @Published var selectedCategory: Category?

    init() {
        loadCategories()
    }

    func loadCategories() {
        guard let url = URL(string: "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54") else {
            print("Invalid Category URL")
            return
        }

        NetworkManager.shared.fetchData(from: url) { (result: Result<CategoryResponse, Error>) in
            switch result {
            case .success(let categoryResponse):
                DispatchQueue.main.async {
                    self.categories = categoryResponse.сategories
                }
            case .failure(let error):
                print("Failed to decode JSON: \(error)")
            }
        }
    }
}
