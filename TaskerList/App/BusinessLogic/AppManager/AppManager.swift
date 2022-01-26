//
//  AppManager.swift
//  TaskerList
//
//  Created by Ilya on 26.01.2022.
//

import UIKit

final class AppManager {
        
    // MARK: - Private properties
    
    private let window: UIWindow
    private var router: TaskRouter?
    
    // MARK: - Inits
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
    }
    
    // MARK: - Public methods
    
    func start() {
        let navigationController = UINavigationController()
        let assemblyBuilder = AssemblyBuilders()
        router = TaskRouter(navigationController: navigationController, asseblyBuilder: assemblyBuilder)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        router?.showTaskScreen()
    }
}
