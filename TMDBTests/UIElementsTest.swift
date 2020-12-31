//
//  UIElementsTest.swift
//  TMDBTests
//
//  Created by Byron Chavarría on 30/12/20.
//

import XCTest

class UIElementsTest: XCTestCase {
    
    lazy var tvShowCell: TvShowsCollectionViewCell = {
        let cell = TvShowsCollectionViewCell()
        return cell
    }()

    func testCastCollectionCell() {
        let castCell = CastCollectionCell()
        XCTAssertNotNil(castCell)
    }
    
    func testTvShowCollectionCell() {
        let tvShowCell = self.tvShowCell
        tvShowCell.tvShowFavoriteButton = UIButton()
        tvShowCell.awakeFromNib()
        XCTAssertNotNil(tvShowCell)
    }

}
