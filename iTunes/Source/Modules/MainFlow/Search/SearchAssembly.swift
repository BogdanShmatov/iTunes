//
//  SearchAssembly.swift
//  iTunes
//
//  Created Bogdan Shmatov on 02.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit

protocol SearchAssemblable: SearchViewProtocol, SearchPresenterOutput {}

final class SearchAssembly {
    
    static func assembly(with output: SearchPresenterOutput) {
        let interactor = SearchInteractor()
        let presenter  = SearchPresenter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.output     = output
        output.presenter     = presenter
    }
}
