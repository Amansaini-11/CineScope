//
//  MovieDetailViewController.swift
//  CineScope
//
//  Created by Aman Saini on 28/06/2026.
//
import UIKit
import SwiftUI

class MovieDetailViewController : UIViewController{
    
    var movie : Movie?
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        titleLabel.text = movie?.title
    }
}
    
    struct MovieDetailViewControllerWrapper: UIViewControllerRepresentable {
        let movie: Movie
        
        func makeUIViewController(context: Context) -> MovieDetailViewController {
            let vc = MovieDetailViewController()
            vc.movie = movie
            return vc
        }
        
        func updateUIViewController(_ uiViewController: MovieDetailViewController, context: Context) {
            // Nothing to update for now
        }
    }
    


#Preview {
    MovieDetailViewController()
}
