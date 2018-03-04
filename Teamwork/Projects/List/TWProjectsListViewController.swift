//
//  TWProjectsListViewController.swift
//  Teamwork
//
//  Created by Rodrigo Kreutz on 3/3/18.
//  Copyright © 2018 Rodrigo Kreutz. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Class

class TWProjectsListViewController: UIViewController {
    
    // MARK: Private variables
    
    private lazy var refreshControl: UIRefreshControl = {
       
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(updateTable), for: .valueChanged)
        return refreshControl
    }()
    
    private var disposeBag = DisposeBag()
    fileprivate let viewModel = TWProjectsListViewModel()
    
    // MARK: Private computed properties
    
    private var emptyTableLabel: UILabel {
        
        let label = UILabel()
        label.text = "It seems you don't have any projects\n😓"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }

    // MARK: IBOutlets
    
    @IBOutlet weak private var tableView: UITableView! {
        
        didSet {
            
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.refreshControl = refreshControl
            tableView.tableFooterView = UIView()
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    // MARK: Overriden methods
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        tableView.setContentOffset(CGPoint(x: 0, y: -100), animated: true)
        refreshControl.beginRefreshing()
        updateTable()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard
            let project = sender as? TWProject,
            let destinationView = segue.destination as? TWProjectDetailViewController
            else { return }
        
        destinationView.viewModel = TWProjectDetailViewModel(project: project)
    }
    
    // MARK: Private methods
    
    @objc private func updateTable() {
        
        viewModel.updateProjects()
            .subscribe(
                onNext: { [weak self] in self?.configureTable(accordingTo: $0) },
                onError: { [weak self] in self?.showError(error: $0) },
                onCompleted: { [weak self] in self?.tableView.reloadData() },
                onDisposed: { [weak self] in self?.refreshControl.endRefreshing() }
            )
            .disposed(by: disposeBag)
    }
    
    private func configureTable(accordingTo projects: [TWProject]) {
        
        self.tableView.backgroundView = projects.isEmpty ? emptyTableLabel : nil
    }
    
    private func showError(error: Error) {
        
        let error = (error as? TWProjectsService.Error) ?? .generic
        
        let alertController = UIAlertController(
            title: "Oops 😅",
            message: error.reason,
            preferredStyle: .alert
        )
        
        let ok = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: nil
        )
        
        alertController.addAction(ok)
        
        DispatchQueue.main.async {
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource

extension TWProjectsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TWProjectTableViewCell.identifier, for: indexPath)
        
        guard
            let projectCell = cell as? TWProjectTableViewCell,
            indexPath.row >= 0,
            indexPath.row < viewModel.projects.count
            else { return cell }
        
        projectCell.configure(withProject: viewModel.projects[indexPath.row])
        return projectCell
    }
}

// MARK: - UITableViewDelegate

extension TWProjectsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard
            indexPath.row >= 0,
            indexPath.row < viewModel.projects.count
            else { return }
        
        let project = viewModel.projects[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: project)
    }
}
