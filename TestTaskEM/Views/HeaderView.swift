//
//  HeaderView.swift
//  TestTaskEM
//
//  Created by Nikita Ivlev on 1/7/23.
//

import SwiftUI

struct HeaderView: View {
    
    @EnvironmentObject var user: UserData

    var body: some View {
        
        HStack {
            Image("location")
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.bottom, 8)
            VStack(alignment: .leading) {
                Text(user.city)
                    .customFont(size: 18, weight: .medium)
                
                Text(getFormattedDate())
                    .customFont(size: 14, kerning: 0.14, color: .black.opacity(0.5))
            }
            Spacer()
            Image(user.userImageURL)
        }
        .padding(.horizontal, 16)
    }
}

func getFormattedDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ru_RU")
    formatter.dateFormat = "d MMMM, yyyy"
    let formattedDate = formatter.string(from: date)
    return formattedDate
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .environmentObject(UserData())
    }
}
