//
//  Categories.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 28/6/23.
//

import Foundation

struct CategoryResponse: Decodable {
    let сategories: [Category]
}

struct Category: Identifiable, Decodable {
    let id: Int
    let name: String
    let image_url: String
}
