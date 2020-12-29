//
//  TvShowsCollectionViewCell.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit

class TvShowsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tvShowImage: UIImageView!
    @IBOutlet weak var tvShowName: UILabel!
    @IBOutlet weak var tvShowReleaseDate: UILabel!
    @IBOutlet weak var tvShowFavoriteButton: UIButton!
    @IBOutlet weak var tvShowRate: UILabel!
    @IBOutlet weak var tvShowDescription: UILabel!
    
    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = R.Colors.dark.color
        self.tvShowFavoriteButton.tintColor = R.Colors.green.color
        self.cornerRadius(
            with: [
                .layerMaxXMinYCorner,
                .layerMinXMinYCorner,
                .layerMaxXMaxYCorner,
                .layerMinXMaxYCorner
            ],
            cornerRadii: 15
        )
    }
    
    // MARK:- Methods

}
