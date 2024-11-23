//
//  SwiftUIView.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by Essam Fahmy on 12/08/2024.
//

import SwiftUI

// MARK: - DEBUG VIEW
// For testing purposes

struct SwiftUIView: View {
    private let viewModel = ViewModel()
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                viewModel.fetchMovies()
            }
    }
}

#Preview {
    SwiftUIView()
}
