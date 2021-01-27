//
//  UserPlanViewController.swift
//  FlinkTest
//
//  Created by Misael Delgado on 25/01/21.
//  Copyright © 2021 Misael Delgado. All rights reserved.
//

import UIKit

class UserPlanViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var versionSegmentControl: UISegmentedControl!
    
    var presenter: ViewToPresenterUserPlanProtocol?
    private var countScrollDown = 0
    var filter = "All"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "User Plan List"
        loadTableView()
        setStyleButton()
        presenter?.getUserPlan()
    }

    func loadTableView() {
        listTableView.rowHeight = UITableView.automaticDimension
        listTableView.estimatedRowHeight = 105.0
        listTableView.register(UINib(nibName: "UserPlanTableViewCell", bundle: nil), forCellReuseIdentifier: "UserPlanCell")
    }
    
    func setStyleButton() {
        calculateButton.layer.cornerRadius = 5
        calculateButton.clipsToBounds = true
    }
    
    func configSegmentControl() {
        versionSegmentControl.removeAllSegments()
        presenter?.getVersions()?.enumerated().forEach {
            versionSegmentControl.insertSegment(withTitle: $0.element, at: $0.offset, animated: false)
        }
        versionSegmentControl.insertSegment(withTitle: "All", at: presenter?.getVersionsCount() ?? 0, animated: false)
        versionSegmentControl.selectedSegmentIndex = presenter?.getVersionsCount() ?? 0
        versionSegmentControl.addTarget(self, action: #selector(selectVersion), for: .valueChanged)
    }
    
    @objc func selectVersion(sender: UISegmentedControl) {
        countScrollDown = 0
        filter = versionSegmentControl.titleForSegment(at: sender.selectedSegmentIndex)!
        presenter?.getUserPlanByVersion(filter: filter)
    }
    
    @IBAction func canculateButton() {
        presenter?.startCalculateActivitysViews(filter: filter)
    }
}

extension UserPlanViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getUserPlanCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserPlanCell") as? UserPlanTableViewCell
        cell?.accessoryType = .disclosureIndicator
        let userPlan = presenter?.getUserPlan(index: indexPath.row)
        cell?.userPlanLabel.text = userPlan?.userPlan
        cell?.releaseDate.text = userPlan?.build.releaseDate
        cell?.npsLabelLabel.text = String(describing: userPlan!.nps + countScrollDown)
        cell?.setColorUserPlanMarker()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.showDetailUserPlanController(navigationController: navigationController!, data: (presenter?.getUserPlan(index: indexPath.row))!)
    }
}

extension UserPlanViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if translation.y < 0 {
            countScrollDown += 1
            DispatchQueue.main.async {
                guard let visibleRows = self.listTableView.indexPathsForVisibleRows else { return }
                self.listTableView.reloadRows(at: visibleRows, with: .none)
            }
        }
    }
}

extension UserPlanViewController: PresenterToViewUserPlanProtocol{
    
    func showVersions() {
        configSegmentControl()
    }
    
    func showUserPlan() {
        listTableView.reloadData()
    }
    
    func showError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityViewsCountMsg(totalActivityViewsMsg: String) {
        let alert = UIAlertController(title: "Activity Views", message: totalActivityViewsMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Hell yeah!!!", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
