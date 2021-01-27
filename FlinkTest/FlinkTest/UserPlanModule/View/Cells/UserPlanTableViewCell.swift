//
//  UserPlanTableViewCell.swift
//  FlinkTest
//
//  Created by Misael Delgado on 26/01/21.
//  Copyright © 2021 Misael Delgado. All rights reserved.
//

import UIKit

class UserPlanTableViewCell: UITableViewCell {

    @IBOutlet weak var userPlanLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var npsLabelLabel: UILabel!
    @IBOutlet weak var userPlanMarkerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userPlanMarkerView.layer.cornerRadius = userPlanMarkerView.frame.size.width/2
        userPlanMarkerView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setColorUserPlanMarker(){
        if userPlanLabel.text == "freemium" {
            userPlanMarkerView.backgroundColor = .blue
        } else {
            userPlanMarkerView.backgroundColor = .red
        }
    }
}
