//
//  UserPlanRouter.swift
//  FlinkTest
//
//  Created by Misael Delgado on 25/01/21.
//  Copyright © 2021 Misael Delgado. All rights reserved.
//

import Foundation
import UIKit

class UserPlanRouter: PresenterToRouterUserPlanProtocol {
    
    static func createUserPlanModule() -> UserPlanViewController {
        let view = UserPlanRouter.instanceFromNib
        let presenter: ViewToPresenterUserPlanProtocol & InteractorToPresenterUserPlanProtocol = UserPlanPresenter()
        let interactor: PresenterToInteractorUserPlanProtocol = UserPlanInteractor()
        let router: PresenterToRouterUserPlanProtocol = UserPlanRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
    
    static var instanceFromNib: UserPlanViewController {
        return UserPlanViewController(nibName: "UserPlanViewController", bundle: nil)
    }
    
    func pushToDetailUserPlanScreen(navigationController: UINavigationController, data: DataUserPlan) {
        let detailUserPlanModue = DetailUserPlanRouter.createDetailUserPlanModule(data: data)
        navigationController.pushViewController(detailUserPlanModue, animated: true)
    }
}
