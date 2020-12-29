//
//  HomeViewControllerCollectionDataSource.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit

final class HomeViewControllerCollectionDataSource: NSObject {
    var delegate: UIResponder?
}

extension HomeViewControllerCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TvShowsCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "TvShowsCollectionViewCell",
            for: indexPath
        ) as! TvShowsCollectionViewCell
        
        return cell
    }
}
