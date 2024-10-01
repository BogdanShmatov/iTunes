//
//  OnboardingCoordinator.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

protocol OnboardingCoordinatorOutput: AnyObject {
    
    var finishFlow: CompletionBlock? { get set }
    
    func include() -> OnboardingViewProtocol
}

final class OnboardingCoordinator: BaseCoordinator, OnboardingCoordinatorOutput {
    var finishFlow: CompletionBlock?
    
    fileprivate let factory: OnboardingFactoryProtocol
    
    fileprivate let router: Routable
    
    init(with factory: OnboardingFactoryProtocol, router: Routable) {
        
        self.factory = factory
        self.router = router
    }
}

extension OnboardingCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
    
    func performFlow() {
        let view = include()
        router.setRootModule(view, hideBar: true)
    }
    
    func include() -> OnboardingViewProtocol {
        let view = factory.makeOnboardingView()
        view.onCompletion = {
            self.finishFlow?()
        }
        return view
    }
}
