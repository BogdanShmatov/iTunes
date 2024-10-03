//
//  MainInteractor.swift
//  iTunes
//
//  Created Bogdan Shmatov on 01.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit
import Cannonball

final class MainInteractor {
    
    weak var presenter: MainPresenter?
    
    private let client = iTunesRequestProvider(environment: .debug)
    
    func searchSongs(by keyWords: String) async {
        do {
            let parameters = ["term": keyWords]
            let response = try await client.search(parameters: parameters)
            presenter?.setSongs(response?.results ?? [])
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
