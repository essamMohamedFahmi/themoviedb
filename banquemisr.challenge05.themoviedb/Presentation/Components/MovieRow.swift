//
//  MovieRow.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie

    var body: some View {
        HStack {
            AsyncImage(url: movie.posterURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 120)
            .cornerRadius(8)

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.releaseDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
