//
//  MovieDetailView.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import SwiftUI

struct MovieDetailView: View {
    // MARK: - Private Properties
    
    @StateObject private var viewModel: MovieDetailViewModel
    
    // MARK: - Init
    
    init(movieId: Int, factory: PresentationFactory) {
        _viewModel = StateObject(wrappedValue: factory.makeMovieDetailViewModel(for: movieId))
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let movieDetail = viewModel.movieDetail {
                // Poster Image
                if let posterURL = movieDetail.posterURL {
                    AsyncImage(url: posterURL) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 300)
                } else {
                    // Placeholder if no posterURL exists
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .overlay(Text("No Image Available").foregroundColor(.white))
                }
                
                // Movie Title
                Text(movieDetail.title)
                    .font(.title)
                    .bold()
                
                // Movie Overview
                Text(movieDetail.overview)
                    .font(.body)
                    .padding(.bottom, 8)
                
                // Movie Details
                VStack(alignment: .leading, spacing: 8) {
                    // Release Date
                    Text("Release Date: \(movieDetail.releaseDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Budget
                    Text("Budget: $\(movieDetail.budget)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Revenue
                    Text("Revenue: $\(movieDetail.revenue)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Runtime
                    Text("Runtime: \(movieDetail.runtime) minutes")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Popularity
                    Text("Popularity: \(String(format: "%.1f", movieDetail.popularity))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // IMDb Link
                    if let imdbURL = URL(string: "https://www.imdb.com/title/\(movieDetail.imdbID)") {
                        Link("IMDb", destination: imdbURL)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                
                Spacer()
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.fetchMovieDetails()
                    }
            }
        }
        .padding()
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
