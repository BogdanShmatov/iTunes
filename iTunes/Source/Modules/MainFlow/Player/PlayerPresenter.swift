//
//  PlayerPresenter.swift
//  iTunes
//
//  Created Bogdan Shmatov on 03.10.2024.
//  Copyright © 2024 iTunes. All rights reserved.
//

import UIKit

protocol PlayerPresenterInput: AnyObject { }

protocol PlayerPresenterOutput: AnyObject {
    var presenter: PlayerPresenterInput? { get set }
}

final class PlayerPresenter {

    weak var output: PlayerPresenterOutput?
    
    var interactor: PlayerInteractor?
}

// MARK: - PlayerPresenterInput
extension PlayerPresenter: PlayerPresenterInput { }
