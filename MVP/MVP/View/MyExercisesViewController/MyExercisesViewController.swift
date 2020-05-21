//
//  ViewController.swift
//  MVP
//
//  Created by admin on 19.05.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol MyExercisesViewControllerProtocol: class {
    
    func setEmptySate() -> Void
    func removeEmptyState() -> Void
    func updateTableView() -> Void
}

class MyExercisesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addExerciseButton: UIControl!
    
    var presenter: MyExercisesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.presenter.title
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.tableHeaderView = UIView(frame: CGRect.zero)
        
        self.prepareUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter.updateExercisesIfNeeded()
        self.presenter.checkEmptyState()
        
    }
    
    //MARK: - Private
    
    private func prepareUI() -> Void {
        self.addExerciseButton.layer.cornerRadius = self.addExerciseButton.bounds.height / 2.0
        self.addExerciseButton.clipsToBounds = true
    }
    
    //MARK: - Public
    
    func addPresenter(presenter: MyExercisesPresenter) -> Void {
        self.presenter = presenter
    }
    
    //MARK: - Action
    
    @IBAction func tapToAddButton(_ sender: Any) {
        RouterService.shared.presentAllExercisesViewController()
    }
    
}

extension MyExercisesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.myExercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseTableViewCell.reuseIdentifier) as! ExerciseTableViewCell
        cell.presenter = ExercisePresenter(withView: cell, exerciseWithIndex: indexPath.row)
        cell.updateCell()
        return cell
    }
    
}

extension MyExercisesViewController: UITableViewDelegate {
    
    static let visibleCellInTable:CGFloat = 9
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / MyExercisesViewController.visibleCellInTable
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.presenter.removeExercise(byIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            self.updateTableView()
        }
    }
    
}

extension MyExercisesViewController: MyExercisesViewControllerProtocol {
    
    func removeEmptyState() {
        self.tableView.superview!.bringSubviewToFront(self.tableView)
    }
    
    func setEmptySate() -> Void {
        self.tableView.superview!.sendSubviewToBack(self.tableView)
    }
    
    func updateTableView() -> Void {
        self.tableView.reloadData()
    }
    
}

