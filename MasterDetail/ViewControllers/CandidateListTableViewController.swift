import Foundation
import UIKit

protocol CandidateListTableViewControllerDelegate: class {
  func candidateWasSelected(_ candidate: Candidate)
}

class CandidateListTableViewController: UITableViewController {

  private let dataSource: CandidateListDatasource
  private let loadingSpinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)

  private lazy var headerLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont.boldSystemFont(ofSize: 17)
    label.textColor = UIColor.gray
    return label
  }()
  
  weak var delegate: CandidateListTableViewControllerDelegate?

  // MARK: - Init

  init(dataSource: CandidateListDatasource) {
    self.dataSource = dataSource

    super.init(style: .plain)

    confugureTableView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func confugureTableView() {
    tableView.dataSource = dataSource
    tableView.rowHeight = UITableView.automaticDimension
    tableView.delegate = self
    tableView.register(CandidateTableViewCellImplementation.self, forCellReuseIdentifier: "CandidateCell")
  }

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    //stop empty cells appearing
    tableView.tableFooterView = UIView(frame: CGRect.zero)

    addHeaderViewToTable()
    updateHeaderLabelText()
    setUpNavBar()
    setUpLoadingSpinner()
    addRefreshControl()
    refreshList()
  }

  // MARK: - UI Setup

  private func addHeaderViewToTable() {
    let headerView = UIView(frame: .zero)
    headerView.translatesAutoresizingMaskIntoConstraints = false
    headerView.heightAnchor.constraint(equalToConstant: 40).isActive = true

    headerView.addSubview(headerLabel)

    headerLabel.translatesAutoresizingMaskIntoConstraints = false
    headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
    headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20).isActive = true

    tableView.tableHeaderView = headerView
  }

  private func updateHeaderLabelText() {
    headerLabel.text = NSLocalizedString("Displaying \(dataSource.candidates.count) candidates", comment: "HeaderText")
  }

  private func setUpNavBar() {
    navigationItem.title = NSLocalizedString("Candidates", comment: "Candidates")

    let backButton = UIBarButtonItem()
    backButton.title = NSLocalizedString("Candidates", comment: "Candidates")
    navigationItem.backBarButtonItem = backButton
  }

  private func setUpLoadingSpinner() {
    loadingSpinner.startAnimating()
    loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(loadingSpinner)

    let horizontalConstraint = NSLayoutConstraint(item: loadingSpinner,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .centerX,
                                                  multiplier: 1,
                                                  constant: 0)
    let verticalConstraint = NSLayoutConstraint(item: loadingSpinner,
                                                attribute: .centerY,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .centerY,
                                                multiplier: 1,
                                                constant: 0)
    NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
  }

  // MARK: - Refresh

  private func addRefreshControl() {
    let refreshControl = UIRefreshControl()

    refreshControl.addTarget(self,
                             action: #selector(refreshList),
                             for: .valueChanged)

    tableView.refreshControl = refreshControl
  }

  @objc func refreshList() {
    self.dataSource.refreshCandidateList { (errorMessage) in
      DispatchQueue.main.async {
        self.hideLoadingSpinner()
        self.refreshControl?.endRefreshing()

        if let errorMessage = errorMessage {
          self.displayErrorAlert(message: errorMessage)
        } else {
          self.updateHeaderLabelText()
          self.tableView.reloadData()
        }
      }
    }
  }

  private func hideLoadingSpinner() {
    UIView.animate(withDuration: 0.3) {
      self.loadingSpinner.alpha = 0
    }
  }

  // MARK: - Error Handling

  private func displayErrorAlert(message: String) {
    let alert = UIAlertController(title: NSLocalizedString("Error", comment: "Error"),
                                  message: message,
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"),
                               style: .default,
                               handler: nil)
    alert.addAction(action)

    present(alert, animated: true)
  }

  // MARK: - Table View Delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)

    if let selectedCandidate = dataSource.candidateForIndexPath(indexPath) {
      delegate?.candidateWasSelected(selectedCandidate)
    }
  }
}

