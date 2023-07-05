//
//  UserData.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 4/7/23.
//

import SwiftUI

class UserData: ObservableObject {
    @Published var name: String?
    @Published var userImageURL: String = "user"
    @Published var city: String = "Санкт - Петербург"
}
