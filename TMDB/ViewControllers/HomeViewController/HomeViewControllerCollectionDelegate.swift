//
//  HomeViewControllerCollectionDelegate.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//


import UIKit

final class HomeViewControllerCollectionDelegate: NSObject {
    var delegate: UIResponder?
}

// MARK: - UICollectionViewDelegate

extension HomeViewControllerCollectionDelegate: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectTvShow()
    }
}
