//
//  UITableView+footerAdjustTableView.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit

extension UITableView {
    func adjustFooterViewHeightToFillTableView() {
        if let tableFooterView = tableFooterView {
            let minHeight = tableFooterView
                .systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
                .height
            
            let currentFooterHeight = tableFooterView.frame.height
            
            let fitHeight = frame.height - adjustedContentInset.top
                - contentSize.height + currentFooterHeight
            
            let nextHeight = (fitHeight > minHeight) ? fitHeight : minHeight
            
            if (round(nextHeight) != round(currentFooterHeight)) {
                var frame = tableFooterView.frame
                frame.size.height = nextHeight
                tableFooterView.frame = frame
                self.tableFooterView = tableFooterView
            }
        }
    }
}
