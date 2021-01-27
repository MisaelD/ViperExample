//
//  DetailUserPlanRouter.swift
//  FlinkTest
//
//  Created by Misael Delgado on 26/01/21.
//  Copyright © 2021 Misael Delgado. All rights reserved.
//

import Foundation

class DetailUserPlanRouter: PresenterToRouterDetailUserPlanProtocol {
    
    static func createDetailUserPlanModule(data: DataUserPlan) -> DetailUserPlanViewController {
        let view = DetailUserPlanRouter.instanceFromNib
        let presenter: ViewToPresenterDetailUserPlanProtocol & InteractorToPresenterDetailUserPlanProtocol = DetailUserPlanPresenter()
        let interactor: PresenterToInteractorDetailUserPlanProtocol = DetailUserPlanInteractor()
        let router: PresenterToRouterDetailUserPlanProtocol = DetailUserPlanRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.userPlan = data
        return view
        
    }
    
    static var instanceFromNib: DetailUserPlanViewController {
        return DetailUserPlanViewController(nibName: "DetailUserPlanViewController", bundle: nil)
    }
}
