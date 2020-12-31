//
//  HomeViewControllerCollectionDelegate.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//


import UIKit

final class HomeViewControllerCollectionDelegate: NSObject {
    var delegate: UIResponder?
    var items: [ResultResponse] = []
}

// MARK: - UICollectionViewDelegate

extension HomeViewControllerCollectionDelegate: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        let width = Int(screenSize.width/2)-14
        return CGSize(width: width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tvId = items[indexPath.row].id
        delegate?.didSelectTvShow(with: tvId ?? 0)
    }
}
