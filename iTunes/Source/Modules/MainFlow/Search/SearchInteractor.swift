//
//  SearchInteractor.swift
//  iTunes
//
//  Created Bogdan Shmatov on 02.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit
import Cannonball

final class SearchInteractor {

    weak var presenter: SearchPresenter?
    
    private let client = iTunesRequestProvider(environment: .debug)
    
    func searchSongs(by keyWords: String) async {
        do {
            let parameters = ["term": keyWords]
            let response = try await client.search(parameters: parameters)
            presenter?.setSongs(response?.results ?? [])
        }
        catch {
            presenter?.output?.searchFailure()
            print(error.localizedDescription)
        }
    }
}
