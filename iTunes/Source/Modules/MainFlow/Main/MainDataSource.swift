//
//  MainDataSource.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 02.10.2024.
//

import UIKit
import AzazelUI

protocol MainDataSourceDelegate: AnyObject {
    var presenter: MainPresenterInput? { get }
    
    var tableView: UITableView { get }
    
    var onShowPlayer: ((Song, [Song]) -> Void)? { get }
}

final class MainDataSource: NSObject {
    
    weak var delegate: MainDataSourceDelegate?
}

// MARK: - MainDataSource && UITableViewDataSource
extension MainDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.presenter?.getSongsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

// MARK: - MainDataSource && UITableViewDelegate
extension MainDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

// MARK: - MainDataSource && UICollectionViewDataSource
extension MainDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.presenter?.getSongsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopMixCollectionViewCell.reuseIdentifier, for: indexPath) as? TopMixCollectionViewCell
        else { return UICollectionViewCell()}
        
        guard let song = delegate?.presenter?.getSong(at: indexPath.row) else { return UICollectionViewCell() }
        
        cell.setupCell(imageURL: song.artworkUrl100 ?? "", title: song.trackName ?? song.artistName ?? "")
        
        return cell
    }
}


// MARK: - MainDataSource && UICollectionViewDelegate
extension MainDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let song = delegate?.presenter?.getSong(at: indexPath.row),
              let songs = delegate?.presenter?.getSongs()
        else {
            return
        }
        delegate?.onShowPlayer?(song, songs)
    }
}

// MARK: - MainDataSource && UICollectionViewDelegateFlowLayout
extension MainDataSource: UICollectionViewDelegateFlowLayout {
}
