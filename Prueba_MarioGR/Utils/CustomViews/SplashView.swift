//
//  SplashView.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                    .padding(.bottom, 16)
                Text("Cargando...")
                    .font(.title2.bold())
            }
        }
    }
}
