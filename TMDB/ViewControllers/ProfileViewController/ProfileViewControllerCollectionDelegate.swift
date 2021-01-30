//
//  ProfileViewControllerCollectionDelegate.swift
//  TMDB
//
//  Created by Byron Chavarría on 4/1/21.
//

import UIKit

final class ProfileViewControllerCollectionDelegate: NSObject { }

// MARK: - UICollectionViewDelegate

extension ProfileViewControllerCollectionDelegate: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        let width = Int(screenSize.width/2)-30
        return CGSize(width: width, height: 350)
    }
}
