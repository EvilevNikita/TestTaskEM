//
//  BasketViewModel.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 1/7/23.
//

import Foundation

class BasketViewModel: ObservableObject {
    @Published var items: [Dish: Int] = [:]

    func addAtBasket(_ dish: Dish) {
        if let count = items[dish] {
            items[dish] = count + 1
        } else {
            items[dish] = 1
        }
    }

    func removeFromBasket(_ dish: Dish) {
        if let count = items[dish], count > 1 {
            items[dish] = count - 1
        } else {
            items.removeValue(forKey: dish)
        }
    }
    
    func totalCost() -> Int {
        items.reduce(0) { $0 + $1.key.price * $1.value }
    }
}

