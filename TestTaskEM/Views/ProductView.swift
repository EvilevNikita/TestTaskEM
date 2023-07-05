//
//  ProductView.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 29/6/23.
//

import SwiftUI

struct ProductView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var productVM: ProductViewModel
    
    let screenSize = UIScreen.main.bounds
    
    var body: some View {
        Group {
            ZStack {
                Color.black.opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                
                if let dish = productVM.selectedDish {
                    ZStack {
                        VStack(spacing: 8) {
                            
                            ProductImageConteiner(screenSize: screenSize)
                            
                            Text(dish.name)
                                .customFont(weight: .medium, kerning: 0.16)
                                .frame(width: screenSize.width - 64, alignment: .leading)
                            HStack {
                                Text("\(dish.price) ₽")
                                    .customFont(size: 14, kerning: 0.14)
                                Text("· \(dish.weight)г")
                                    .customFont(size: 14, kerning: 0.14, color: .black.opacity(0.15))
                                Spacer()
                            }
                            Text(dish.description)
                                .customFont(size: 14, kerning: 0.14, color: .black.opacity(0.65))
                                .frame(width: screenSize.width - 64, alignment: .leading)
                                .lineLimit(nil)
                            
                            ButtonAddToBasket(dish: dish)
                        }
                        .padding()
                    }
                    .background(Color.white)
                    .frame(maxWidth: screenSize.width - 32)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
        }
    }
}

struct ProductImageConteiner: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var productVM: ProductViewModel
    
    var screenSize: CGRect
    
    var body: some View {
        if let dish = productVM.selectedDish {
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
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            // Add to favorites
                        }) {
                            ZStack {
                                Color.white
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(8)
                                Image("heart")
                            }
                        }
                        .padding(.top, 8)
                        .padding(.trailing, 8)
                        
                        Button(action: {
                            coordinator.closeProductView()
                        }) {
                            ZStack {
                                Color.white
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(8)
                                Image("dismiss")
                            }
                        }
                        .padding(.top, 8)
                        .padding(.trailing, 8)
                    }
                    Spacer()
                }
            }
            .frame(width: screenSize.width - 64, height: screenSize.width * 0.75 )
            .cornerRadius(10)
        }
    }
}

struct ButtonAddToBasket: View {
    
    @EnvironmentObject var basketVM: BasketViewModel
    
    var dish: Dish
    
    var body: some View {
        Button(action: {
            if basketVM.items[dish] == nil {
                basketVM.addAtBasket(dish)
            }
        }) {
            ZStack {
                Color(red: 0.2, green: 0.39, blue: 0.88)
                Text("Добавить в корзину")
                    .customFont(weight: .medium, kerning: 0.1, color: .white)
            }
            .cornerRadius(10)
            .frame(height: 48)
            .padding(.top, 8)
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let dish = Dish(id: 0, name: "Sample Dish", price: 0, weight: 0, description: "A delicious sample dish.", image_url: "", tegs: [])
        let product = ProductViewModel()
        product.selectedDish = dish
        
        return ProductView()
            .environmentObject(Coordinator())
            .environmentObject(BasketViewModel())
            .environmentObject(product)
    }
}
