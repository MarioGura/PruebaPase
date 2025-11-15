//
//  Prueba_MarioGRApp.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/12/25.
//

import SwiftUI

@main
struct Prueba_MarioGRApp: App {
    @StateObject private var viewModel: CharacterViewModel
    @State private var isLoading: Bool = true

    init() {
        AppContainer.shared.setup()
        let vm = AppContainer.shared.container.resolve(CharacterViewModel.self)!
        _viewModel = StateObject(wrappedValue: vm)
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                CharacterView(viewModel: viewModel)
                    .opacity(isLoading ? 0 : 1)

                if isLoading {
                    SplashView()
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadCharacters(reset: true)
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        }
    }
}

