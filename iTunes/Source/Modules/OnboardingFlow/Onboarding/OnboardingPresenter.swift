//
//  OnboardingPresenter.swift
//  iTunes
//
//  Created Bogdan Shmatov on 01.10.2024.
//  Copyright © 2024. All rights reserved.
//

import UIKit

protocol OnboardingPresenterInput: AnyObject { }

protocol OnboardingPresenterOutput: AnyObject {
    var presenter: OnboardingPresenterInput? { get set }
}

final class OnboardingPresenter {

    weak var output: OnboardingPresenterOutput?
    
    var interactor: OnboardingInteractor?
}

// MARK: - OnboardingPresenterInput
extension OnboardingPresenter: OnboardingPresenterInput { }
