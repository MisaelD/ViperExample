//
//  UserPlanModel.swift
//  FlinkTest
//
//  Created by Misael Delgado on 25/01/21.
//  Copyright © 2021 Misael Delgado. All rights reserved.
//

import Foundation

struct UserPlanModel: Codable {
    let success: Bool
    let code: Int
    let message: String
    let data: DataJson
}

struct DataJson: Codable {
    let data: [DataUserPlan]
}

struct DataUserPlan: Codable {
    let build: Build
    let id: Int
    let activityViews: Int
    let daysSinceSignup: Int
    let userPlan: String
    let nps: Int

    enum CodingKeys: String, CodingKey {
        case build
        case id
        case activityViews = "activity_views"
        case daysSinceSignup = "days_since_signup"
        case userPlan = "user_plan"
        case nps
    }
}

struct Build: Codable {
    let releaseDate: String
    let version: String

    enum CodingKeys: String, CodingKey {
        case releaseDate = "release_date"
        case version
    }
}
