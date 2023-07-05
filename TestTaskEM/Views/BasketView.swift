//
//  BasketView.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 1/7/23.
//

import SwiftUI

struct BasketView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var basketVM: BasketViewModel
    @EnvironmentObject var user: UserData

    var body: some View {
        VStack {
            
            HeaderView()
            
            if basketVM.items.count == 0 {
                Spacer()
                Text("Ваша корзина пуста")
                    .customFont(size: 20, color: .black.opacity(0.5))
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(Array(basketVM.items.keys), id: \.self) { dish in
                            if let dishCount = basketVM.items[dish], dishCount > 0 {
                                HStack {
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
                                    .frame(width: 62, height: 62)
                                    .cornerRadius(6)
                                    
                                    VStack(alignment: .leading) {
                                        Text(dish.name)
                                            .customFont(size: 14, kerning: 0.14)
                                        HStack {
                                            Text("\(dish.price) ₽")
                                                .customFont(size: 14, kerning: 0.14)
                                            Text("\(dish.weight)г")
                                                .customFont(size: 14, kerning: 0.14, color: .black.opacity(0.5))
                                        }
                                    }
                                    Spacer()
                                    
                                    BasketCountPicker(dish: dish, dishCount: dishCount)
                                }
                            }
                        }
                        .padding(.top, 16)
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
            
            PayButton()
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
        .environmentObject(basketVM)
    }
}


struct PayButton: View {
    @EnvironmentObject var basketVM: BasketViewModel
    
    var body: some View {
        Button(action: {
            // Handle pay action
        }) {
            ZStack {
                Color(red: 51/255, green: 100/255, blue: 224/255)
                    .frame(height: 48)
                    .cornerRadius(10)
                Text("Оплатить \(basketVM.totalCost()) ₽")
                    .customFont(weight: .medium, kerning: 0.1, color: .white)
            }
        }
    }
}


struct BasketCountPicker: View {
    @EnvironmentObject var basketVM: BasketViewModel
    
    var dish: Dish
    var dishCount: Int
    
    var body: some View {
        ZStack {
            Color(red: 0.94, green: 0.93, blue: 0.93)
            
            HStack {
                Button(action: {
                    basketVM.removeFromBasket(dish)
                }) {
                    Image("-")
                        .frame(width: 24, height: 24)
                }
                
                Text("\(dishCount)")
                    .customFont(size: 14, weight: .medium, kerning: 0.14)
                    .frame(width: 24, alignment: .center)
                
                Button(action: {
                    basketVM.addAtBasket(dish)
                }) {
                    Image("+")
                        .frame(width: 24, height: 24)
                }
            }
        }
        .frame(width: 99, height: 32)
        .cornerRadius(8)
    }
}


struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
            .environmentObject(BasketViewModel())
            .environmentObject(UserData())
    }
}
