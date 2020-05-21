//
//  WorkoutTableViewCell.swift
//  MVP
//
//  Created by admin on 19.05.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol ExerciseTableViewCellProtocol: class {
    
    func setIndex(index: String) -> Void
    func setNameOfExercise(name: String) -> Void
    func setDateOfExercise(date: String) -> Void
    
}

class ExerciseTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "cellOfExercise"
    var presenter: ExercisePresenter!
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.updateCellUI()
    }
    
    func updateCell() -> Void {
        presenter.updateUIWithData()
    }
    
    //MARK: - Private
    
    private func updateCellUI() -> Void {
        self.indexLabel.layer.cornerRadius = self.indexLabel.bounds.height / 2.0
        self.indexLabel.clipsToBounds = true
    }
}

extension ExerciseTableViewCell: ExerciseTableViewCellProtocol {
    
    func setIndex(index: String) -> Void {
        self.indexLabel.text = index
    }
    
    func setNameOfExercise(name: String) -> Void {
        self.nameLabel.text = name
    }
    
    func setDateOfExercise(date: String) -> Void {
        self.dateLabel.text = date
    }
    
}
