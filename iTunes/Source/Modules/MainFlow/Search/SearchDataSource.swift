//
//  SearchDataSource.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 02.10.2024.
//  Copyright © 2024 iTunes. All rights reserved.
//

import UIKit
import AzazelUI
import Cannonball

protocol SearchDataSourceDelegate: AnyObject {
    var presenter: SearchPresenterInput? { get }
    
    var tableView: UITableView { get }
    
    var onShowPlayer: ((Song, [Song]) -> Void)? { get }
}

final class SearchDataSource: NSObject {
    
    weak var delegate: SearchDataSourceDelegate?
    
    public var isLoading = false
    
    private func genetateVibration(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(type)
    }
}

// MARK: - SearchDataSource && UITableViewDataSource
extension SearchDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoading ? 15 : delegate?.presenter?.getSongsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard isLoading == false
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentlyPlayedSceletonTableViewCell.reuseIdentifier, for: indexPath) as? RecentlyPlayedSceletonTableViewCell
            cell?.backgroundColor = .clear
            cell?.setupCell()
            
            return cell ?? UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentlyPlayedTableViewCell.reuseIdentifier, for: indexPath) as? RecentlyPlayedTableViewCell
        else { return UITableViewCell()}
        
        guard let song = delegate?.presenter?.getSong(at: indexPath.row) else { return UITableViewCell() }
        
        cell.setupCell(imageURL: song.artworkUrl100 ?? "",
                       track: song.trackName ?? song.primaryGenreName ?? "",
                       artist: song.artistName ?? "")
        cell.backgroundColor = .clear
        
        return cell
    }
}

// MARK: - SearchDataSource && UITableViewDelegate
extension SearchDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isLoading { return }
        
        tableView.deselectRow(at: indexPath, animated: true)
        guard let song = delegate?.presenter?.getSong(at: indexPath.row),
              let songs = delegate?.presenter?.getSongs()
        else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        delegate?.onShowPlayer?(song, songs)
    }
}

// MARK: - SearchDataSource && UISearchBarDelegate
extension SearchDataSource: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let trimmedText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              trimmedText.count > 3,
              trimmedText != ""
        else {
            genetateVibration(.error)
            return
        }
        
        isLoading = true
        delegate?.tableView.reloadData()
        Task {
           await delegate?.presenter?.searchSongs(by: trimmedText)
        }
        
        searchBar.resignFirstResponder()
        genetateVibration(.success)
        return
    }
}
