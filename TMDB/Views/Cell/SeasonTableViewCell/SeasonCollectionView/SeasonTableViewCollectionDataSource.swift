//
//  SeasonTableViewCollectionDataSource.swift
//  TMDB
//
//  Created by Byron Chavarría on 31/12/20.
//

import UIKit
import Nuke

final class SeasonTableViewCollectionDataSource: NSObject {
    var items: [Episode] = []
}

extension SeasonTableViewCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SeasonCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonCollectionViewCell", for: indexPath) as! SeasonCollectionViewCell
        let episode = items[indexPath.row]
        let options = K.NukeDefault.options
        let url = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(episode.stillPath ?? "")")!
        Nuke.loadImage(with: url, options: options, into: cell.episodeImage)
        cell.episodeName.text = episode.name
        return cell
    }
}
