//
//  AppCoordinator.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

import UIKit
import SwiftUI

private enum LaunchInstructor {
    case onboarding, main
    
    static func setup() -> LaunchInstructor {
        
        if Session.isSeenOnboarding {
            return .main
        } else {
            return .onboarding
        }
    }
}

final class AppCoordinator: BaseCoordinator {
    
    fileprivate let factory: CoordinatorFactoryProtocol
    fileprivate let router: Routable
    
    fileprivate var instructor: LaunchInstructor {
        return LaunchInstructor.setup()
    }
    
    init(router: Routable, factory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
    }
}


// MARK: - Coordinatable
extension AppCoordinator: Coordinatable {
    
    func start() {
        switch instructor {
        case .onboarding: performOnboardingFlow()
        case .main: performMainFlow()
        }
    }
    
    func performOnboardingFlow() {
        var coordinator = factory.makeOnboardingCoordinator(router: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func performMainFlow() {
        var coordinator = factory.makeMainCoordinator(router: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
