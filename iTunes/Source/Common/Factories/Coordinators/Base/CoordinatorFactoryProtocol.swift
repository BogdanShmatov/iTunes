//
//  CoordinatorFactoryProtocol.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

import Foundation

protocol CoordinatorFactoryProtocol {

    func makeOnboardingCoordinator(router: Routable) -> OnboardingCoordinatorOutput & Coordinatable
    
    func makeMainCoordinator(router: Routable) -> MainCoordinatorOutput & Coordinatable
}
