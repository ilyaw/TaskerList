//
//  TaskPresenter.swift
//  TaskerList
//
//  Created by Ilya on 26.01.2022.
//

import Foundation
import UIKit

protocol TaskPresenterInput: AnyObject {
    var taskView: TaskView { get }
}

protocol TaskPresenterOutput: AnyObject {
    var taskList: [Task] { get }
    func fetchTask()
    func selectTask(id: Int)
}

class TaskPresenter {

    // MARK: - Public properties
    
    weak var input: (UIViewController & TaskPresenterInput)?
    
    // MARK: - Private properties
    
    private(set) var taskList: [Task] = []
    private let router: Router

    // MARK: - Inits
    
    init(router: TaskRouter) {
        self.router = router
    }
}

// MARK: - TaskPresenter + TaskPresenterOutput

extension TaskPresenter: TaskPresenterOutput {
    func fetchTask() {
        let taskList = [Task(id: 1, title: "Some task dfgkdfmgkdfmgkmflgfdmgmdfkglfdklgdfg1"),
                        Task(id: 2, title: "Some task 2"),
                        Task(id: 3, title: "Some task 3"),
                        Task(id: 4, title: "Some task 4"),
                        Task(id: 5, title: "Some task 5")]
        self.taskList = taskList

        input?.taskView.tableView.reloadData()
    }
    
    func selectTask(id: Int) {
        router.showProposalScreen(taskId: id)
    }
}
