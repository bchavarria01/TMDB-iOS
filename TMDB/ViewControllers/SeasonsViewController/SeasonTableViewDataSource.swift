//
//  SeasonTableViewDataSource.swift
//  TMDB
//
//  Created by Byron Chavarría on 31/12/20.
//

import UIKit

final class SeasonTableViewDataSource: NSObject {
    var items: [EpisodesModel] = []
}

extension SeasonTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SeasonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SeasonTableViewCell") as! SeasonTableViewCell
        cell.backgroundColor = R.Colors.almostBlack.color
        cell.seasonName.text = items[indexPath.row].seasonName
        cell.setupEpisodes(with: items[indexPath.row].episodes ?? [])
        cell.selectionStyle = .none
        return cell
    }
}
