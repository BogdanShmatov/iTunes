//
//  MainAssembly.swift
//  iTunes
//
//  Created Bogdan Shmatov on 01.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit

protocol MainAssemblable: MainViewProtocol, MainPresenterOutput {}

final class MainAssembly {
    
    static func assembly(with output: MainPresenterOutput) {
        let interactor = MainInteractor()
        let presenter  = MainPresenter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.output     = output
        output.presenter     = presenter
    }
}
