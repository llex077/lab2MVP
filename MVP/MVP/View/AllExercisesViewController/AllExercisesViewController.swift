//
//  AllExercisesViewController.swift
//  MVP
//
//  Created by admin on 19.05.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol AllExercisesViewControllerProtocol: class {
    func updateTableView() -> Void
}

class AllExercisesViewController: UIViewController {
    
    var presenter: AllExercisesPresenter!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.presenter.title
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.setupNavigationBar()
        self.prepareUI()
    }
    
    //MARK: - Private
    
    private func prepareUI() -> Void {
        
    }
    
    private func setupNavigationBar() -> Void {
        let cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tapToCancelButton(_:)))
        self.navigationItem.leftBarButtonItem = cancelBarButtonItem
        
    }
    
    @objc
    private func tapToCancelButton(_: UIBarButtonItem?) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AllExercisesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.filterAllExercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllExercisesPresenter.reuseIdentifier)!
        cell.textLabel?.text = self.presenter.nameExercise(atIndex: indexPath.row)
        
        return cell
    }
}

extension AllExercisesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.addExercise(atIndex: indexPath.row)
        self.tapToCancelButton(nil)
    }
    
}

extension AllExercisesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.filterAllExercises(byText: searchText)
    }
    
}

extension AllExercisesViewController: AllExercisesViewControllerProtocol {
    
    func updateTableView() -> Void {
        self.tableView.reloadData()
    }
    
}
