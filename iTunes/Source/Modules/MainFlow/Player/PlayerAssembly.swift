//
//  PlayerAssembly.swift
//  iTunes
//
//  Created Bogdan Shmatov on 03.10.2024.
//  Copyright © 2024 iTunes. All rights reserved.
//

import UIKit

protocol PlayerAssemblable: PlayerViewProtocol, PlayerPresenterOutput {}

final class PlayerAssembly {
    
    static func assembly(with output: PlayerPresenterOutput) {
        let interactor = PlayerInteractor()
        let presenter  = PlayerPresenter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.output     = output
        output.presenter     = presenter
    }
}
