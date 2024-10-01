//
//  CoordinatorFactory.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

final class CoordinatorFactory {
    fileprivate let modulesFactory = ModulesFactory()
}

extension CoordinatorFactory: CoordinatorFactoryProtocol {
    
    func makeMainCoordinator(router: Routable) -> Coordinatable & MainCoordinatorOutput {
        return MainCoordinator(with: modulesFactory, router: router)
    }
    
    func makeOnboardingCoordinator(router: Routable) -> Coordinatable & OnboardingCoordinatorOutput {
        return OnboardingCoordinator(with: modulesFactory, router: router)
    }
}
