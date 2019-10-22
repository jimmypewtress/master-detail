import Foundation
import UIKit

protocol Coordinator {
  func start()
}

class ApplicationCoordinator: Coordinator {
  private let window: UIWindow?
  private let apiClient: APIClient
  private let candidateListDataSource: CandidateListDatasource
  private var navigationController: UINavigationController?
  
  init(window: UIWindow?, apiClient: APIClient, candidateListDataSource: CandidateListDatasource) {
    self.window = window
    self.apiClient = apiClient
    self.candidateListDataSource = candidateListDataSource
  }
  
  func start() {
    showRootViewController()
  }
  
  private func showRootViewController() {
    let tableView = CandidateListTableViewController(dataSource: candidateListDataSource)
    tableView.delegate = self
    
    navigationController = UINavigationController(rootViewController: tableView)
    
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
  
  private func showDetailViewController(candidate: Candidate) {
    let cdvc = CandidateDetailViewController(candidate: candidate)
    navigationController?.pushViewController(cdvc, animated: true)
  }
}

extension ApplicationCoordinator: CandidateListTableViewControllerDelegate {
  
  func candidateWasSelected(_ candidate: Candidate) {
    showDetailViewController(candidate: candidate)
  }
}




