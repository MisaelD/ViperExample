//
//  UserPlanPresenter.swift
//  FlinkTest
//
//  Created by Misael Delgado on 25/01/21.
//  Copyright © 2021 Misael Delgado. All rights reserved.
//

import Foundation
import UIKit

class UserPlanPresenter: ViewToPresenterUserPlanProtocol {
    
    var view: PresenterToViewUserPlanProtocol?
    var interactor: PresenterToInteractorUserPlanProtocol?
    var router: PresenterToRouterUserPlanProtocol?
    
    func getUserPlan() {
        interactor?.fetchUserPlan()
    }
    
    func getUserPlanCount() -> Int? {
        return interactor?.userPlanList?.count
    }
    
    func getUserPlan(index: Int) -> DataUserPlan? {
        return interactor?.userPlanList?[index]
    }
    
    func getVersions() -> [String]? {
        return interactor?.versions
    }
    
    func getVersionsCount() -> Int? {
        return interactor?.versions?.count
    }
    
    func getUserPlanByVersion(filter: String) {
        interactor?.filterUserPlanByVersion(filter: filter)
    }
    
    func showDetailUserPlanController(navigationController: UINavigationController, data: DataUserPlan) {
        router?.pushToDetailUserPlanScreen(navigationController: navigationController, data: data)
    }
    
    func startCalculateActivitysViews(filter: String) {
        interactor?.calculateActivityViews(filter: filter)
    }
}

extension UserPlanPresenter: InteractorToPresenterUserPlanProtocol {
    
    func userVersionFetched() {
        view?.showVersions()
    }
    
    func userPlanFetched() {
        view?.showUserPlan()
    }
    
    func userPlanFetchFailed(error: String) {
        view?.showError(error: error)
    }
    
    func calculatedActivityViewsByVersion(totalActivityViewsMsg: String) {
        view?.showActivityViewsCountMsg(totalActivityViewsMsg: totalActivityViewsMsg)
    }
}
