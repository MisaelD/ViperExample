//
//  DetailUserPlanViewController.swift
//  FlinkTest
//
//  Created by Misael Delgado on 26/01/21.
//  Copyright © 2021 Misael Delgado. All rights reserved.
//

import UIKit

class DetailUserPlanViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var userPlanLabel: UILabel!
    @IBOutlet weak var activityViewsLabel: UILabel!
    @IBOutlet weak var npsLabel: UILabel!
    @IBOutlet weak var daysSinceSignup: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var userPlanMarkerView: UIView!
    
    var presenter: ViewToPresenterDetailUserPlanProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        userPlanMarkerView.layer.cornerRadius = userPlanMarkerView.frame.size.width/2
        userPlanMarkerView.clipsToBounds = true
        presenter?.getDetailUserPlan()
    }
    
    func setColorUserPlanMarker(){
        if userPlanLabel.text == "freemium" {
            userPlanMarkerView.backgroundColor = .blue
        } else {
            userPlanMarkerView.backgroundColor = .red
        }
    }
}

extension DetailUserPlanViewController:PresenterToViewDetailUserPlanProtocol {
    
    func showUserPlan() {
        
        let userPlan = presenter?.getUserPlan()
        
        idLabel.text = String(userPlan?.id ?? 0)
        userPlanLabel.text = userPlan?.userPlan
        activityViewsLabel.text = String(userPlan?.activityViews ?? 0)
        npsLabel.text = String(userPlan?.nps ?? 0)
        daysSinceSignup.text = String(userPlan?.daysSinceSignup ?? 0)
        releaseDateLabel.text = userPlan?.build.releaseDate
        versionLabel.text = userPlan?.build.version
        setColorUserPlanMarker()
    }
}
