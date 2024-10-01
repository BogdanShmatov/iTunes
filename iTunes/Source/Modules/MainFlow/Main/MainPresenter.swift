//
//  MainPresenter.swift
//  iTunes
//
//  Created Bogdan Shmatov on 01.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit

protocol MainPresenterInput: AnyObject { }

protocol MainPresenterOutput: AnyObject {
    var presenter: MainPresenterInput? { get set }
}

final class MainPresenter {

    weak var output: MainPresenterOutput?
    
    var interactor: MainInteractor?
}

// MARK: - MainPresenterInput
extension MainPresenter: MainPresenterInput { }
