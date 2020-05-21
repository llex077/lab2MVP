//
//  ExercisePresenter.swift
//  MVP
//
//  Created by admin on 19.05.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ExercisePresenter: NSObject {
    
    unowned let view: ExerciseTableViewCellProtocol!
    let exerciseModel: ExerciseModel
    
    init(withView view: ExerciseTableViewCellProtocol, exerciseWithIndex index: Int) {
        self.view = view
        self.exerciseModel = CoreDataService.shared.myExercise(byIndex: index)
        
        super.init()
    }
    
    func updateUIWithData() -> Void {
        self.view.setIndex(index: String(self.exerciseModel.index))
        self.view.setNameOfExercise(name: self.exerciseModel.name)
        self.view.setDateOfExercise(date: self.exerciseModel.getFormattedDate())
    }
}
