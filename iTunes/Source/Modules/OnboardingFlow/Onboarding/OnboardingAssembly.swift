//
//  OnboardingAssembly.swift
//  iTunes
//
//  Created Bogdan Shmatov on 01.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit

protocol OnboardingAssemblable: OnboardingViewProtocol, OnboardingPresenterOutput {}

final class OnboardingAssembly {
    
    static func assembly(with output: OnboardingPresenterOutput) {
        let interactor = OnboardingInteractor()
        let presenter  = OnboardingPresenter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.output     = output
        output.presenter     = presenter
    }
}
