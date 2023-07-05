//
//  MainView.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 28/6/23.
//

import SwiftUI

struct MainView: View {

    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var categoryVM: CategoryViewModel
    @EnvironmentObject var user: UserData

    var body: some View {
        NavigationView {
            VStack {
                HeaderView()
                
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(categoryVM.categories) { category in

                            VStack {
                                GeometryReader { geometry in
                                    let aspectRatio: CGFloat = 343 / 148
                                    let calculatedHeight = geometry.size.width / aspectRatio
                                    ZStack {
                                        Color(red: 0.97, green: 0.97, blue: 0.96)

                                        AsyncImage(url: URL(string: category.image_url)) { phase in
                                            switch phase {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .overlay(
                                                        Text(category.name)
                                                            .customFont(size: 20, weight: .medium, kerning: 0.2, color: .black)
                                                            .frame(width: 191, height: 50, alignment: .topLeading)
                                                            .multilineTextAlignment(.leading)
                                                            .padding(.top, 12)
                                                            .padding(.leading, 16),
                                                        alignment: .topLeading
                                                    )
                                            case .failure:
                                                Text("Failed to load image")
                                            case .empty:
                                                ProgressView()
                                            @unknown default:
                                                ProgressView()
                                            }
                                        }
                                        .onTapGesture {
                                            self.categoryVM.selectedCategory = category
                                            coordinator.push(.categoryView, to: $coordinator.mainPath)
                                        }
                                    }
                                    .frame(width: geometry.size.width, height: calculatedHeight)
                                    .cornerRadius(10)
                                }
                                .aspectRatio(343/148, contentMode: .fit)
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                    .background(Color.white)
                }
                
                .onAppear {
                    categoryVM.loadCategories()
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CategoryViewModel())
            .environmentObject(UserData())
    }
}
