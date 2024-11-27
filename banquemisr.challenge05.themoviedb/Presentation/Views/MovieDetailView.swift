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
    
    // MARK: - View Properties
    
    var posterImagePlaceholder: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .frame(maxWidth: .infinity, maxHeight: 300)
            .overlay(Text("No Image Available").foregroundColor(.white))
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let movieDetail = viewModel.movieDetail {
                if let posterURL = movieDetail.posterURL {
                    AsyncImage(url: posterURL) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 300)
                } else {
                    posterImagePlaceholder
                }
                
                Text(movieDetail.title)
                    .font(.title)
                    .bold()
                
                Text(movieDetail.overview)
                    .font(.body)
                    .padding(.bottom, 8)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(movieDetail.releaseDate)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(movieDetail.budget)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(movieDetail.revenue)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(movieDetail.runtime)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(movieDetail.popularity)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    if let imdbURL = movieDetail.imdbURL {
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
