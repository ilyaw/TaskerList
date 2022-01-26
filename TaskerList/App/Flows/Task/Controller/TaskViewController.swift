//
//  TaskViewController.swift
//  TaskerList
//
//  Created by Ilya on 26.01.2022.
//

import UIKit

class TaskViewController: UIViewController, TaskPresenterInput {

    // MARK: - Public properties
    
    var taskView: TaskView {
        return (view as? TaskView) ?? TaskView()
    }
    
    // MARK: - Private properties
    
    private var presenter: TaskPresenterOutput
    
    // MARK: - Inits
    
    init(presenter: TaskPresenterOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = TaskView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Задачи"
        
        setupTable()
        presenter.fetchTask()
    }
    
    private func setupTable() {
        taskView.tableView.register(TaskViewCell.self,
                                    forCellReuseIdentifier: TaskViewCell.reuseId)
        
        taskView.tableView.delegate = self
        taskView.tableView.dataSource = self
    }
}

// MARK: - TaskViewController + UITableViewDelegate

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - TaskViewController + UITableViewDataSource

extension TaskViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskViewCell.reuseId,
                                                       for: indexPath) as? TaskViewCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(with: presenter.taskList[indexPath.row])
        cell.delegate = self
        return cell
    }
}

// MARK: - TaskViewController + RespondDelegate

extension TaskViewController: RespondDelegate {
    func didTapRespond(id: Int) {
        presenter.selectTask(id: id)
    }
}
