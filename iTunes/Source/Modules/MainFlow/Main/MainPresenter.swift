//
//  MainPresenter.swift
//  iTunes
//
//  Created Bogdan Shmatov on 01.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit
import Cannonball

protocol MainPresenterInput: AnyObject {
    func searchSongs(by keyWords: String) async
    
    func getSongs() -> [Song]
    func getSong(at index: Int) -> Song?
    func getSongsCount() -> Int
}

protocol MainPresenterOutput: AnyObject {
    var presenter: MainPresenterInput? { get set }
    
    func searchProceed()
}

final class MainPresenter {

    weak var output: MainPresenterOutput?
    
    var interactor: MainInteractor?
    
    private var songs: [Song] = []
    
    func setSongs(_ songs: [Song]) {
        self.songs = songs
        output?.searchProceed()
    }
}

// MARK: - MainPresenterInput
extension MainPresenter: MainPresenterInput {
    func searchSongs(by keyWords: String) async {
        await interactor?.searchSongs(by: keyWords)
    }
    
    func getSongs() -> [Song] {
        return songs
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
