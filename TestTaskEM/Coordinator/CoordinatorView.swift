//
//  CoordinatorView.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 3/7/23.
//

import SwiftUI

struct CoordinatorView: View {

    @StateObject var coordinator = Coordinator()
    @StateObject var categoryVM: CategoryViewModel
    @StateObject var productVM: ProductViewModel
    @StateObject var basketVM: BasketViewModel
    @StateObject var dishesVM: DishesViewModel
    @StateObject var user: UserData

    init(categoryVM: CategoryViewModel, productVM: ProductViewModel, basketVM: BasketViewModel, dishesVM: DishesViewModel, user: UserData) {
        self._categoryVM = StateObject(wrappedValue: categoryVM)
        self._productVM = StateObject(wrappedValue: productVM)
        self._basketVM = StateObject(wrappedValue: basketVM)
        self._dishesVM = StateObject(wrappedValue: dishesVM)
        self._user = StateObject(wrappedValue: user)

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.white

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

    var body: some View {

        TabView(selection: $coordinator.selectedTab) {

            MainPath()

            Text("Search")
                .tabItem {
                    Image("search").renderingMode(.template)
                    Text("Поиск")
                        .customFont(size: 10, weight: .medium, kerning: 0.1, color: Color(red: 0.2, green: 0.39, blue: 0.88))
                        .multilineTextAlignment(.center)
                }

            BasketPath()

            Text("Account")
                .tabItem {
                    Image("account").renderingMode(.template)
                    Text("Аккаунт")
                        .customFont(size: 10, weight: .medium, kerning: 0.1, color: Color(red: 0.2, green: 0.39, blue: 0.88))
                        .multilineTextAlignment(.center)
                }
        }
        .toolbarBackground(.hidden, for: .tabBar)
        .background(Color.white)
        .accentColor(Color(red: 51/255, green: 100/255, blue: 224/255, opacity: 1))

        .overlay(
            Group {
                if coordinator.productViewIsPresented {
                    ProductView()
                        .environmentObject(productVM)
                }
            }
        )

        .environmentObject(coordinator)
        .environmentObject(categoryVM)
        .environmentObject(productVM)
        .environmentObject(basketVM)
        .environmentObject(dishesVM)
        .environmentObject(user)
    }
}

struct MainPath: View {

    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        NavigationStack(path: $coordinator.mainPath) {
            coordinator.build(page: .mainView)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
        }
        .tag(Page.mainView)
        .tabItem {
            Image("main").renderingMode(.template)
            Text("Главная")
                .customFont(size: 10, weight: .medium, kerning: 0.1, color: Color(red: 0.2, green: 0.39, blue: 0.88))
                .multilineTextAlignment(.center)
        }
    }
}

struct BasketPath: View {

    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        NavigationStack(path: $coordinator.basketPath) {
            coordinator.build(page: .basketView)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
        }
        .tag(Page.basketView)
        .tabItem {
            Image("basket").renderingMode(.template)
            Text("Корзина")
                .customFont(size: 10, weight: .medium, kerning: 0.1, color: Color(red: 0.2, green: 0.39, blue: 0.88))
                .multilineTextAlignment(.center)
        }
    }
}



struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView(categoryVM: CategoryViewModel(),
                        productVM: ProductViewModel(),
                        basketVM: BasketViewModel(),
                        dishesVM: DishesViewModel(),
                        user: UserData())
    }
}
