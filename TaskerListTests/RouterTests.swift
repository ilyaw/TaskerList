//
//  RouterTests.swift
//  TaskerListTests
//
//  Created by Ilya on 26.01.2022.
//

import XCTest
@testable import TaskerList

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: true)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        self.presentedVC = self.viewControllers.first
        return super.popToRootViewController(animated: animated)
    }
}

class RouterTests: XCTestCase {

    var router: Router!
    var navigationController = MockNavigationController()
    
    override func setUpWithError() throws {
        router = TaskRouter(navigationController: navigationController, asseblyBuilder: AssemblyBuilders())
    }

    override func tearDownWithError() throws {
        router = nil
    }

    func testShowTaskSceen() throws {
        router.showTaskScreen()
        let taskVC = navigationController.presentedVC
        
        XCTAssertTrue(taskVC is TaskViewController)
    }
    
    func testShowProposalScreen() throws {
        router.showProposalScreen(taskId: 1)
        let taskVC = navigationController.presentedVC
        
        XCTAssertTrue(taskVC is ProposalViewController)
    }
    
    func testsPopToRootScreen() throws {
        router.showTaskScreen()
        router.showProposalScreen(taskId: 1)
        router.popToRootScreen()

        let taskVC = navigationController.presentedVC
        
        XCTAssertTrue(taskVC is TaskViewController)
    }
}
