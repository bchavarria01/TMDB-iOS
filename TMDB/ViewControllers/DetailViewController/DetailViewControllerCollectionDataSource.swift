//
//  DetailViewControllerCollectionDataSource.swift
//  TMDB
//
//  Created by Byron Chavarría on 29/12/20.
//

import UIKit

final class DetailViewControllerCollectionDataSource: NSObject {
    var delegate: UIResponder?
}

extension DetailViewControllerCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CastCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCollectionCell", for: indexPath) as! CastCollectionCell        
        return cell
    }
}
