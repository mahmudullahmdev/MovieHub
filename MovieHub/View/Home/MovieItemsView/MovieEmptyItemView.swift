//
//  MovieEmptyItemView.swift
//  MovieHub
//
//  Created by Mahmudullah on 17/2/24.
//

import SwiftUI

struct MovieEmptyItemView: View {
    var body: some View {
        GeometryReader { gm in
            HStack {
                Color(UIColor.systemGray5)
                    .frame(width: gm.size.width/3, height: gm.size.width/2)
                
                VStack(alignment:.leading, spacing: 10) {
                   Rectangle()
                        .foregroundColor(Color(UIColor.systemGray5))
                        .frame(width: gm.size.width/1.8, height: gm.size.width/9)
                        .cornerRadius(10)
                    Rectangle()
                         .foregroundColor(Color(UIColor.systemGray5))
                         .frame(width: gm.size.width/1.8, height: gm.size.width/9)
                         .cornerRadius(10)
                    Rectangle()
                         .foregroundColor(Color(UIColor.systemGray5))
                         .frame(width: gm.size.width/1.8, height: gm.size.width/9)
                         .cornerRadius(10)
                    
                }
            }
            .padding(.all, 10)
        }
    }
}

#Preview {
    MovieEmptyItemView()
}
