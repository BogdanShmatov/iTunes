//
//  BaseCoordinator.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

import Foundation

class BaseCoordinator {
    
    var childCoordinators: [Coordinatable] = []

    func addDependency(_ coordinator: Coordinatable) {
        for element in childCoordinators {
            if element === coordinator {return}
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinatable?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
        else { return }

        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func removeAllDependencyies() {
        childCoordinators = []
    }
}
