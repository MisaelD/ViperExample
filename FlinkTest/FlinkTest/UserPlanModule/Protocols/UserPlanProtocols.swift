//
//  UserPlanProtocols.swift
//  FlinkTest
//
//  Created by Misael Delgado on 25/01/21.
//  Copyright © 2021 Misael Delgado. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterUserPlanProtocol: class {
    var view: PresenterToViewUserPlanProtocol? { get set }
    var interactor: PresenterToInteractorUserPlanProtocol? { get set }
    var router: PresenterToRouterUserPlanProtocol? { get set }
    func getUserPlan()
    func getUserPlanCount() -> Int?
    func getUserPlan(index: Int) -> DataUserPlan?
    func getVersions() -> [String]?
    func getVersionsCount() -> Int?
    func getUserPlanByVersion(filter: String)
    func showDetailUserPlanController(navigationController: UINavigationController, data: DataUserPlan)
    func startCalculateActivitysViews(filter: String)
}

protocol PresenterToViewUserPlanProtocol: class {
    func showUserPlan()
    func showVersions()
    func showError(error: String)
    func showActivityViewsCountMsg(totalActivityViewsMsg: String)
}

protocol PresenterToInteractorUserPlanProtocol: class {
    var presenter: InteractorToPresenterUserPlanProtocol? { get set }
    var userPlanList: [DataUserPlan]? { get }
    var versions: [String]? { get }
    func fetchUserPlan()
    func filterUserPlanByVersion(filter: String)
    func calculateActivityViews(filter: String)
}

protocol InteractorToPresenterUserPlanProtocol: class {
    func userPlanFetched()
    func userVersionFetched()
    func userPlanFetchFailed(error: String)
    func calculatedActivityViewsByVersion(totalActivityViewsMsg: String)
}

protocol PresenterToRouterUserPlanProtocol: class {
    static func createUserPlanModule() -> UserPlanViewController
    func pushToDetailUserPlanScreen(navigationController: UINavigationController, data: DataUserPlan)
}
