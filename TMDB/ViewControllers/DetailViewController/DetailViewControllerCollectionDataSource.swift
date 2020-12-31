//
//  DetailViewControllerCollectionDataSource.swift
//  TMDB
//
//  Created by Byron Chavarría on 29/12/20.
//

import UIKit
import Nuke

final class DetailViewControllerCollectionDataSource: NSObject {
    var delegate: UIResponder?
    var items: [Cast] = []
}

extension DetailViewControllerCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CastCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCollectionCell", for: indexPath) as! CastCollectionCell
        let cast = items[indexPath.row]
        let options = K.NukeDefault.options
        let url = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(cast.profilePath ?? "")")!
        Nuke.loadImage(with: url, options: options, into: cell.actorImage)
        cell.actorName.text = cast.name
        return cell
    }
}
