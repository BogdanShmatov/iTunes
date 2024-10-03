//
//  ModulesFactoy.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

import UIKit

final class ModulesFactory {}

// MARK: - MainFactoryProtocol
extension ModulesFactory: MainFactoryProtocol {
    func makeMainView() -> any MainViewProtocol {
        let view = MainViewController()
        MainAssembly.assembly(with: view)
        return view
    }
    
    func makeSearchView() -> any SearchViewProtocol {
        let view = SearchViewController()
        SearchAssembly.assembly(with: view)
        return view
    }
    
    func makePlayerView() -> any PlayerViewProtocol {
        let view = PlayerViewController()
        PlayerAssembly.assembly(with: view)
        return view
    }
}

// MARK: - OnboardingFactoryProtocol
extension ModulesFactory: OnboardingFactoryProtocol {
    func makeOnboardingView() -> any OnboardingViewProtocol {
        let view = OnboardingViewController()
        OnboardingAssembly.assembly(with: view)
        return view
    }
}
