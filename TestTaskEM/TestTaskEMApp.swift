//
//  TestTaskEMApp.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 28/6/23.
//

import SwiftUI

@main
struct TestTaskEMApp: App {
    var body: some Scene {
        WindowGroup {
            CoordinatorView(categoryVM: CategoryViewModel(),
                            productVM: ProductViewModel(),
                            basketVM: BasketViewModel(),
                            dishesVM: DishesViewModel(),
                            user: UserData())
        }
    }
}
