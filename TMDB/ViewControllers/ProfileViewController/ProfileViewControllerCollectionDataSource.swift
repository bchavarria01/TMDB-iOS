//
//  ProfileViewControllerCollectionDataSource.swift
//  TMDB
//
//  Created by Byron Chavarría on 4/1/21.
//

import Nuke
import UIKit
import Reusable

final class ProfileViewControllerCollectionDataSource: NSObject {
    var items: [TvShowsModel] = []
}

extension ProfileViewControllerCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TvShowsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.tvShowFavoriteButton.tintColor = R.Colors.green.color
        let tvShowInfo = items[indexPath.row]
        cell.tvShowDescription.text = tvShowInfo.overview
        cell.tvShowName.text = tvShowInfo.name
        let options = K.NukeDefault.options
        let url = URL(string: "\(DefaultPreferences.current.loadImageBaseString ?? "")\(tvShowInfo.posterPath ?? "")")!
        if tvShowInfo.posterPath != "" {
            Nuke.loadImage(with: url, options: options, into: cell.tvShowImage)
        } else {
            cell.tvShowImage.image = UIImage(data: tvShowInfo.imageData ?? Data())
        }
        cell.tvShowReleaseDate.text = tvShowInfo.firstAirDate ?? ""
        let rateValue = String(format: "%.1f", tvShowInfo.voteAverage ?? 0)
        cell.tvShowRate.text = rateValue
        return cell
    }
}

