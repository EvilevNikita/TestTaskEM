//
//  CustomToolbar.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 3/7/23.
//

// Пришлось сделать кастомный тулбар, т.к при использовании нативного тулбар фото пользователя в правом верхнем углу представления имеет разное позиционирование с header, это сильно заметно при переключении вкладок в таббаре

import SwiftUI

struct CustomToolbar: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var user: UserData
    
    @Environment(\.presentationMode) var presentationMode
    
    var categoryName: String
    
    var body: some View {
        HStack {
            Button(action: {
                coordinator.pop(from: $coordinator.mainPath)
            }) {
                Image("vector-3")
            }
            
            Spacer()
            
            Text(categoryName)
                .customFont(size: 18, weight: .medium)
            
            Spacer()
            
            Image(user.userImageURL)
        }
        .padding(.horizontal)
    }
}

struct CustomToolbar_Previews: PreviewProvider {
    static var previews: some View {
        CustomToolbar(categoryName: "Категория")
            .environmentObject(UserData())
    }
}
