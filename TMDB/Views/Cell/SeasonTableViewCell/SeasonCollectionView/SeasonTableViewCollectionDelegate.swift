//
//  SeasonTableViewCollectionDelegate.swift
//  TMDB
//
//  Created by Byron Chavarría on 31/12/20.
//

import UIKit

final class SeasonTableViewCollectionDelegate: NSObject {
    
}

extension SeasonTableViewCollectionDelegate: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 215, height: collectionView.frame.height - 20)
    }
}
