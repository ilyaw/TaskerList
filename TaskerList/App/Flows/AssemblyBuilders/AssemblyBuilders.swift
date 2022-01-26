//
//  AssemblyBuilders.swift
//  TaskerList
//
//  Created by Ilya on 26.01.2022.
//

import UIKit

final class AssemblyBuilders {
    func taskScreenBuild(router: TaskRouter) -> UIViewController {
        let presenter = TaskPresenter(router: router)
        let controller = TaskViewController(presenter: presenter)
        presenter.input = controller
        return controller
    }
    
    func proposalScreenBuild(router: TaskRouter, taskId: Int) -> UIViewController {
        let presenter = ProposalPresenter(router: router, taskId: taskId)
        let controller = ProposalViewController(presenter: presenter)
        presenter.input = controller
        return controller
    }
}
