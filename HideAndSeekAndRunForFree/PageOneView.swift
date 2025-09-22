//
//  PageOneView.swift
//  HideAndSeekAndRunForFree
//
//  Created by Lester Arguello on 4/7/25.
//

import SwiftUI

struct PageOneView: View {
    var body: some View {
        ZStack {
            Image("page1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    PageOneView()
}
