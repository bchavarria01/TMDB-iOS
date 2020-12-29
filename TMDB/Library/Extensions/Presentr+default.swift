//
//  Presentr+default.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import Presentr

extension Presentr {
    static func defaultPresenter(width: ModalSize, height: ModalSize ) -> Presentr {
        let center = ModalCenterPosition.center
        let customType = PresentationType.custom(
            width: width,
            height: height,
            center: center
        )
        
        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = .coverVerticalFromTop
        customPresenter.dismissTransitionType = .crossDissolve
        customPresenter.roundCorners = true
        customPresenter.backgroundColor = .black
        customPresenter.backgroundOpacity = 0.4
        customPresenter.dismissOnSwipe = false
        customPresenter.transitionType = nil
        customPresenter.dismissTransitionType = nil
        customPresenter.dismissAnimated = true

        return customPresenter
    }
}
