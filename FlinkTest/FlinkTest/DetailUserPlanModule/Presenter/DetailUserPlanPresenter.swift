//
//  DetailUserPlanPresenter.swift
//  FlinkTest
//
//  Created by Misael Delgado on 26/01/21.
//  Copyright © 2021 Misael Delgado. All rights reserved.
//

import Foundation

class DetailUserPlanPresenter: ViewToPresenterDetailUserPlanProtocol {
    
    var view: PresenterToViewDetailUserPlanProtocol?
    var interactor: PresenterToInteractorDetailUserPlanProtocol?
    var router: PresenterToRouterDetailUserPlanProtocol?
    
    func getDetailUserPlan() {
        interactor?.getDetailUserPlan()
    }
    
    func getUserPlan() -> DataUserPlan? {
        return interactor?.userPlan
    }
}

extension DetailUserPlanPresenter: InteractorToPresenterDetailUserPlanProtocol {
    func detailUserPlanData() {
        view?.showUserPlan()
    }
}
