//
//  Dishes.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 28/6/23.
//

import Foundation

struct DishesResponse: Decodable {
    let dishes: [Dish]
}

struct Dish: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let price: Int
    let weight: Int
    let description: String
    let image_url: String
    let tegs: [String]
}
