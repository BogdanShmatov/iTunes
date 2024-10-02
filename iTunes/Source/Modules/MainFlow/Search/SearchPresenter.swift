//
//  SearchPresenter.swift
//  iTunes
//
//  Created Bogdan Shmatov on 02.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit
import Cannonball

protocol SearchPresenterInput: AnyObject {
    func searchSongs(by keyWords: String) async
    
    func getSong(at index: Int) -> Song?
    func getSongsCount() -> Int
}

protocol SearchPresenterOutput: AnyObject {
    var presenter: SearchPresenterInput? { get set }
    
    func searchProceed()
    func searchFailure()
}

final class SearchPresenter {

    weak var output: SearchPresenterOutput?
    
    var interactor: SearchInteractor?
    
    private var songs: [Song] = []
    
    func setSongs(_ songs: [Song]) {
        self.songs = songs
        output?.searchProceed()
    }
}

// MARK: - SearchPresenterInput
extension SearchPresenter: SearchPresenterInput {
    func searchSongs(by keyWords: String) async {
        await interactor?.searchSongs(by: keyWords)
    }
    
    func getSong(at index: Int) -> Song? {
        if index <= songs.count {
            return songs[index]
        }
        return nil
    }
    
    func getSongsCount() -> Int {
        return songs.count
    }
}
