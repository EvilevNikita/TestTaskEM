//
//  Coordinator.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 3/7/23.
//

import SwiftUI

enum Page: String, Identifiable {
    case mainView, categoryView, basketView
    
    var id: String {
        self.rawValue
    }
}

class Coordinator: ObservableObject {
    
    @ObservedObject var productVM = ProductViewModel()
    @ObservedObject var basketVM = BasketViewModel()
    @ObservedObject var categoryVM = CategoryViewModel()
    @ObservedObject var dishesVM = DishesViewModel()
    
    @Published var mainPath = NavigationPath()
    @Published var basketPath = NavigationPath()
    @Published var selectedTab: Page = .mainView
    @Published var productViewIsPresented = false
    
    func push(_ page: Page, to path: Binding<NavigationPath>) {
        path.wrappedValue.append(page)
    }
    
    func pop(from path: Binding<NavigationPath>) {
        path.wrappedValue.removeLast()
    }
    
    func openProductView() {
        productViewIsPresented = true
    }
    
    func closeProductView() {
        productViewIsPresented = false
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .mainView:
            MainView()
        case .categoryView:
            CategoryView()
        case .basketView:
            BasketView()
        }
    }
}
