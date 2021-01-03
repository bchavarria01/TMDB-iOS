//
//  SeasonTableViewCollectionDataSource.swift
//  TMDB
//
//  Created by Byron Chavarría on 31/12/20.
//

import UIKit
import Nuke

final class SeasonTableViewCollectionDataSource: NSObject {
    var items: [CustomEpisode] = []
}

extension SeasonTableViewCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SeasonCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonCollectionViewCell", for: indexPath) as! SeasonCollectionViewCell
        let episode = items[indexPath.row]
        if episode.episodePath != "" {
            let options = K.NukeDefault.options
            let url = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(episode.episodePath ?? "")")!
            Nuke.loadImage(with: url, options: options, into: cell.episodeImage)
        } else {
            cell.episodeImage.image = UIImage(data: episode.episodeImage ?? Data())
        }
        cell.episodeName.text = episode.episodeName
        return cell
    }
}
