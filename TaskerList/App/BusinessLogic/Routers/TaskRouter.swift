//
//  TaskRouter.swift
//  TaskerList
//
//  Created by Ilya on 26.01.2022.
//

import Foundation
import UIKit

protocol Router {
    func showTaskScreen()
    func showProposalScreen(taskId: Int)
    func popToRootScreen()
}

class TaskRouter {
    
    // MARK: - Private properties
    
    private let navigationController: UINavigationController
    private let assemblyBuilder: AssemblyBuilders
    
    // MARK: - Inits
    
    init(navigationController: UINavigationController, asseblyBuilder: AssemblyBuilders) {
        self.navigationController = navigationController
        self.assemblyBuilder = asseblyBuilder
    }
}

// MARK: - TaskRouter + Router

extension TaskRouter: Router {
    func showTaskScreen() {
        let controller = assemblyBuilder.taskScreenBuild(router: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showProposalScreen(taskId: Int) {
        let controller = assemblyBuilder.proposalScreenBuild(router: self, taskId: taskId)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func popToRootScreen() {
        navigationController.popToRootViewController(animated: true)
    }
}
