//
//  CategoryView.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 28/6/23.
//

import SwiftUI

struct CategoryView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var categoryVM: CategoryViewModel
    @EnvironmentObject private var dishesVM: DishesViewModel
    @EnvironmentObject private var productVM: ProductViewModel
    
    var body: some View {
        VStack {
            CustomToolbar(categoryName: categoryVM.selectedCategory?.name ?? "Category name")
            
            GeometryReader { geometry in
                let gridSize = (geometry.size.width - 48) / 3
                let columns: [GridItem] = Array(repeating: .init(.fixed(gridSize)), count: 3)
                ScrollView {
                    VStack {
                        TagsSelector()
                        
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(dishesVM.dishes.filter { dishesVM.selectedTag == "Все меню" ? true : $0.tegs.contains(dishesVM.selectedTag) }) { dish in 
                                Button(action: {
                                    self.productVM.selectedDish = dish
                                    DispatchQueue.main.async {
                                        self.coordinator.openProductView()
                                    }
                                }) {
                                    VStack {
                                        ZStack {
                                            Color(red: 0.97, green: 0.97, blue: 0.96)
                                            
                                            AsyncImage(url: URL(string: dish.image_url)) { phase in
                                                switch phase {
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                case .failure:
                                                    Text("Failed to load image")
                                                case .empty:
                                                    ProgressView()
                                                @unknown default:
                                                    ProgressView()
                                                }
                                            }
                                            .scaleEffect(0.8)
                                        }
                                        .frame(width: gridSize, height: gridSize)
                                        .cornerRadius(10)
                                        
                                        Text(dish.name)
                                            .customFont(size: 14, kerning: 0.14)
                                            .frame(width: gridSize, height: 33, alignment: .topLeading)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    .toolbar(.hidden)
                }
                .onAppear {
                    dishesVM.loadDishes()
                }
            }
        }
    }
}

struct TagsSelector: View {
    
    @EnvironmentObject var dishesVM: DishesViewModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(dishesVM.tags, id: \.self) { tag in
                    Button(action: {
                        dishesVM.selectedTag = tag
                    }) {
                        Text(tag)
                            .customFont(size: 14, color: dishesVM.selectedTag == tag ? Color.white : Color.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(dishesVM.selectedTag == tag ? Color(red: 0.2, green: 0.39, blue: 0.88) : Color(red: 0.97, green: 0.97, blue: 0.96))
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            dishesVM.loadDishes()
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
            .environmentObject(ProductViewModel())
            .environmentObject(DishesViewModel())
            .environmentObject(CategoryViewModel())
            .environmentObject(Coordinator())
            .environmentObject(UserData())
    }
}
