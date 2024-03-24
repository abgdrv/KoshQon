//
//  BaseCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation

class BaseCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var childCoordinators: [Coordinator] = []
    var alertFlowFactory: AlertFlowFactory?
    
    // MARK: - Object Lifecycle
    
    init() {}
    
    init(alertFlowFactory: AlertFlowFactory) {
        self.alertFlowFactory = alertFlowFactory
    }
    
    // MARK: - Methods
    
    func start() {}
    
    func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }
        
        if let bCoordinator = coordinator as? BaseCoordinator, !bCoordinator.childCoordinators.isEmpty {
            bCoordinator.childCoordinators
                .filter({ $0 !== bCoordinator })
                .forEach({ bCoordinator.removeDependency($0) })
        }
        
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}
