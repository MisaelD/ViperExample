//
//  DetailUserPlanProtocols.swift
//  FlinkTest
//
//  Created by Misael Delgado on 26/01/21.
//  Copyright © 2021 Misael Delgado. All rights reserved.
//

import Foundation

protocol ViewToPresenterDetailUserPlanProtocol: class {
    var view: PresenterToViewDetailUserPlanProtocol? { get set }
    var interactor: PresenterToInteractorDetailUserPlanProtocol? { get set }
    var router: PresenterToRouterDetailUserPlanProtocol? { get set }
    func getDetailUserPlan()
    func getUserPlan() -> DataUserPlan?
}

protocol PresenterToViewDetailUserPlanProtocol: class {
    func showUserPlan()
}

protocol PresenterToInteractorDetailUserPlanProtocol: class {
    var presenter: InteractorToPresenterDetailUserPlanProtocol? { get set }
    var userPlan: DataUserPlan? { get set }
    func getDetailUserPlan()
}

protocol InteractorToPresenterDetailUserPlanProtocol: class {
    func detailUserPlanData()
}

protocol PresenterToRouterDetailUserPlanProtocol: class {
    static func createDetailUserPlanModule(data: DataUserPlan) -> DetailUserPlanViewController
}
