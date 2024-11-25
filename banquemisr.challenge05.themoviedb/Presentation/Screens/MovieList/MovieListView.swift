//
//  MovieListView.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import SwiftUI

struct MovieListView: View {
    // MARK: - Private Properties
    
    private let category: MovieCategory
    private let factory: PresentationFactory
    
    @StateObject private var viewModel: MovieListViewModel

    // MARK: - Init

    init(category: MovieCategory, factory: PresentationFactory) {
        self.category = category
        self.factory = factory
        _viewModel = StateObject(wrappedValue: factory.makeMovieListViewModel(for: category))
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
                NavigationLink(destination: createMovieDetailView(for: movie.id)) {
                    MovieRow(movie: movie)
                }
            }
            .navigationTitle(category.displayName)
            .onAppear {
                viewModel.fetchMovies()
            }
            .alert(isPresented: $viewModel.hasError) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // MARK: - Methods
    
    @ViewBuilder
    private func createMovieDetailView(for movieId: Int) -> some View {
        MovieDetailView(movieId: movieId, factory: factory)
    }
}
