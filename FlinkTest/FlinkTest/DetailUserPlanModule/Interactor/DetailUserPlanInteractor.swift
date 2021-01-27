//
//  DetailUserPlanInteractor.swift
//  FlinkTest
//
//  Created by Misael Delgado on 26/01/21.
//  Copyright © 2021 Misael Delgado. All rights reserved.
//

import Foundation

class DetailUserPlanInteractor: PresenterToInteractorDetailUserPlanProtocol {
    
    var userPlan: DataUserPlan?
    var presenter: InteractorToPresenterDetailUserPlanProtocol?
    
    func getDetailUserPlan() {
        presenter?.detailUserPlanData()
    }
}
