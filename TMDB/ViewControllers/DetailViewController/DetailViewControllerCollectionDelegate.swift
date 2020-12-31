//
//  DetailViewControllerCollectionDelegate.swift
//  TMDB
//
//  Created by Byron Chavarría on 29/12/20.
//

import UIKit

final class DetailViewControllerCollectionDelegate: NSObject {
}

// MARK: - UICollectionViewDelegate

extension DetailViewControllerCollectionDelegate: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 148)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
