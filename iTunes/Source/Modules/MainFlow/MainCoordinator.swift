//
//  MainCoordinator.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

protocol MainCoordinatorOutput {
    var finishFlow: CompletionBlock? { get set }
    func include() -> MainViewProtocol
}

final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let factory: MainFactoryProtocol
    fileprivate let router: Routable
    
    init(with factory: MainFactoryProtocol, router: Routable) {
        self.factory = factory
        self.router = router
    }
}

extension MainCoordinator: Coordinatable {
    
    func start() {
        performFlow()
    }
    
    func performFlow() {
        let view = include()
        router.setRootModule(view)
    }
    
    func include() -> MainViewProtocol {
        let view = factory.makeMainView()
        view.onCompletion = {
            self.finishFlow?()
        }
        view.onShowSearch = showSearchView
        return view
    }
    
    func showSearchView() {
        let view = factory.makeSearchView()
        router.push(view)
    }
}
