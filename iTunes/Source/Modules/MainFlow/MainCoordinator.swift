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
        view.onShowPlayer = showPlayerView
        return view
    }
    
    func showSearchView() {
        let view = factory.makeSearchView()
        view.onShowPlayer = showPlayerView
        router.push(view)
    }
    
    func showPlayerView(_ selectedSong: Song, _ songs: [Song]) {
        let view = factory.makePlayerView()
        view.selectedSong = selectedSong
        view.songs = songs
        router.push(view)
    }
}
