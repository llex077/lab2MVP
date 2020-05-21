//
//  MyExercisesPresenter.swift
//  MVP
//
//  Created by admin on 19.05.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class MyExercisesPresenter: NSObject {
    
    unowned let view: MyExercisesViewControllerProtocol!
    
    var myExercises: [ExerciseModel]
    var title = "Workouts"
    
    init(withView view: MyExercisesViewControllerProtocol) {
        self.view = view
        
        self.myExercises = CoreDataService.shared.fetchMyExercises()
        
        super.init()
    }
    
    //MARK: - Public
    
    func checkEmptyState() -> Void {
        if myExercises.count > 0 {
            self.view.removeEmptyState()
        } else {
            self.view.setEmptySate()
        }
    }
    
    func updateExercisesIfNeeded() -> Void {
        let newExercises = CoreDataService.shared.fetchMyExercises()
        
        if newExercises == self.myExercises {
            return
        }
        self.myExercises = newExercises
        self.view.updateTableView()
    }
    
    func removeExercise(byIndex index: Int) -> Void {
        self.myExercises.remove(at: index)
        CoreDataService.shared.removeMyExercise(byIndex: index)
        
        for i in index..<self.myExercises.count {
            self.myExercises[i].index -= 1
        }
        self.checkEmptyState()
    }
    
}
