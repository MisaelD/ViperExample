//
//  UserPlanInteractor.swift
//  FlinkTest
//
//  Created by Misael Delgado on 25/01/21.
//  Copyright © 2021 Misael Delgado. All rights reserved.
//

import Foundation

class UserPlanInteractor: PresenterToInteractorUserPlanProtocol {
    
    weak var presenter: InteractorToPresenterUserPlanProtocol?
    var userPlanList: [DataUserPlan]?
    var versions: [String]?
    
    func fetchUserPlan() {
        if isKeyPresentInUserDefaults() {
            getUserPlanFromUserDefaults()
        } else {
            getUserPlanFromURL()
        }
    }
    
    func filterUserPlanByVersion(filter: String) {
        let userDefaults = UserDefaults.standard
        let userPlanString = userDefaults.string(forKey: "UserPlanData")
        parse(jsonString: userPlanString ?? "", filter: filter)
    }
    
    func calculateActivityViews(filter: String) {
        getUserPlanFromUserDefaultsToCalculateActivityViews(filter: filter)
    }
    
    private func getUserPlanFromURL() {
        DispatchQueue.global(qos: .utility).async {
            let result = API().makeAPICall()
            DispatchQueue.main.async {
                switch result {
                    case let .success(string):
                        self.saveUserPlanDataToUserDefaults(jsonString: string ?? "")
                        self.parse(jsonString: string ?? "")
                    case let .failure(error):
                        self.presenter?.userPlanFetchFailed(error: error.localizedDescription)
                }
            }
        }
    }
    
    private func getUserPlanFromUserDefaults(filter: String? = nil) {
        let userDefaults = UserDefaults.standard
        let userPlanString = userDefaults.string(forKey: "UserPlanData")
        parse(jsonString: userPlanString ?? "", filter: filter)
    }
    
    private func parse(jsonString: String, filter: String? = nil) {
        if let data = jsonString.data(using: .utf8) {
            do {
                let decodedData = try JSONDecoder().decode(UserPlanModel.self, from: data)
                
                if let filter = filter, filter != "All" {
                    userPlanList = decodedData.data.data.filter( {$0.build.version == filter} )
                    //self.presenter?.userPlanFilteredByVersion(userPlanListFiltered: filteredByVersion)
                } else {
                    //let versions = Array(Set(decodedData.data.data.map{ $0.build.version }))
                    //self.presenter?.userPlanFetchSuccess(userPlanList: decodedData.data.data, versions: versions)
                    userPlanList = decodedData.data.data
                    
                    if versions == nil {
                        versions = Array(Set(decodedData.data.data.map{ $0.build.version }))
                        presenter?.userVersionFetched()
                    }
                }
                presenter?.userPlanFetched()
            } catch {
                presenter?.userPlanFetchFailed(error: "Problem Fetching Notice")
            }
        }
    }
    
    private func saveUserPlanDataToUserDefaults(jsonString: String) {
        let defaults = UserDefaults.standard
        defaults.set(jsonString, forKey: "UserPlanData")
        defaults.synchronize()
    }
    
    private func isKeyPresentInUserDefaults() -> Bool {
        return UserDefaults.standard.object(forKey: "UserPlanData") != nil
    }
    
    private func getUserPlanFromUserDefaultsToCalculateActivityViews(filter: String? = nil) {
        let userDefaults = UserDefaults.standard
        let userPlanString = userDefaults.string(forKey: "UserPlanData")
        parseToCalculateActivityViews(jsonString: userPlanString ?? "", filter: filter ?? "")
    }
    
    private func parseToCalculateActivityViews(jsonString: String, filter: String) {
        
        if let data = jsonString.data(using: .utf8) {
            do {
                let decodedData = try JSONDecoder().decode(UserPlanModel.self, from: data)
                
                var totalActivityViewsByVersion = 0
                var totalActivityViewsByPremium = 0
                var totalActivityViewsByFremium = 0
                
                if filter != "All" {
                    let filteredByVersion = decodedData.data.data.filter({$0.build.version == filter})
                    let filteredByPremium = filteredByVersion.filter({$0.userPlan == "premium"})
                    let filteredByFreemium = filteredByVersion.filter({$0.userPlan == "freemium"})
                    
                    totalActivityViewsByVersion = filteredByVersion.reduce(0) { $0 + $1.activityViews }
                    totalActivityViewsByPremium = filteredByPremium.reduce(0) { $0 + $1.activityViews }
                    totalActivityViewsByFremium = filteredByFreemium.reduce(0) { $0 + $1.activityViews }
                    
                } else {
                    let filteredByPremium = decodedData.data.data.filter({$0.userPlan == "premium"})
                    let filteredByFreemium = decodedData.data.data.filter({$0.userPlan == "freemium"})
                    
                    totalActivityViewsByVersion = decodedData.data.data.reduce(0) { $0 + $1.activityViews }
                    totalActivityViewsByPremium = filteredByPremium.reduce(0) { $0 + $1.activityViews }
                    totalActivityViewsByFremium = filteredByFreemium.reduce(0) { $0 + $1.activityViews }
                }
                
                let totalActivityViewsMessage = "\n\(totalActivityViewsByVersion) activity views in \(filter) version\n\n\(totalActivityViewsByPremium) activity views by premium\n\n\(totalActivityViewsByFremium) activity views by freemium"
                
                self.presenter?.calculatedActivityViewsByVersion(totalActivityViewsMsg: totalActivityViewsMessage)
                
            } catch {
                self.presenter?.userPlanFetchFailed(error: "Problem Fetching Notice")
            }
        }
    }
}
