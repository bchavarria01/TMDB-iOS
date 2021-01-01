//
//  SeasonTableViewDelegate.swift
//  TMDB
//
//  Created by Byron Chavarría on 31/12/20.
//

import UIKit

final class SeasonTableViewDelegate: NSObject {
    
}

extension SeasonTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(200)
    }
}
