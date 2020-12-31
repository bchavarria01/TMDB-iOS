//
//  HomeViewControllerCollectionDataSource.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit
import Nuke

final class HomeViewControllerCollectionDataSource: NSObject {
    var delegate: UIResponder?
    var items: [ResultResponse] = []
}

extension HomeViewControllerCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TvShowsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TvShowsCollectionViewCell", for: indexPath) as! TvShowsCollectionViewCell
        cell.tvShowFavoriteButton.tintColor = R.Colors.green.color
        let tvShowInfo = items[indexPath.row]
        cell.tvShowDescription.text = tvShowInfo.overview
        cell.tvShowName.text = tvShowInfo.name
        let options = K.NukeDefault.options
        let url = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(tvShowInfo.posterPath ?? "")")!
        Nuke.loadImage(with: url, options: options, into: cell.tvShowImage)
        cell.tvShowReleaseDate.text = tvShowInfo.firstAirDate ?? ""
        cell.tvShowRate.text = String(tvShowInfo.voteAverage ?? 0)
        return cell
    }
}
